const std = @import("std");
const builtin = @import("builtin");
const EErr = @import("error.zig");

pub const configurator = struct {
    allocator: std.mem.Allocator,
    io: std.Io,
    cfgfile: []const u8,
    filebuf: []u8,
    roblox_log_dir: []u8,

    pub fn init(io: std.Io, gpa: std.mem.Allocator, environmap: *std.process.Environ.Map) !@This() {
        const env = switch (builtin.os.tag) {
            .windows => "USERPROFILE",
            else => "HOME",
        };
        const buf: ?[]const u8 = blk: for (environmap.keys(), environmap.values()) |key, value| {
            if (std.mem.eql(u8, key, env)) break :blk value;
        } else null;
        if (buf == null) EErr.print_error(EErr.EError.HomeVariableEnvironnementDontExist, "Create " ++ env ++ " env", true);
        const path = if (std.mem.eql(u8, env, "USERPROFILE")) blk: {
            break :blk try std.fmt.allocPrint(gpa, "{s}\\.edlinuxmacro\\config.cfg", .{buf.?});
        } else blk2: {
            break :blk2 try std.fmt.allocPrint(gpa, "{s}/.edlinuxmacro/config.cfg", .{buf.?});
        };
        std.log.info("Inited configurator", .{});
        return .{
            .allocator = gpa,
            .io = io,
            .cfgfile = path,
            .filebuf = try gpa.alloc(u8, 1),
            .roblox_log_dir = undefined,
        };
    }

    pub fn create_config(self: *@This()) !void {
        try std.Io.Dir.cwd().createDirPath(self.io, self.cfgfile[0 .. self.cfgfile.len - 11]);
        const file = try std.Io.Dir.createFileAbsolute(self.io, self.cfgfile, .{});
        defer file.close(self.io);

        var buf: [2048]u8 = undefined;
        const default = "[rld]>Here the path to your log dir<\n";

        var file_writer = file.writer(self.io, &buf);
        const writer_iface: *std.Io.Writer = &file_writer.interface;
        try writer_iface.writeAll(default);
        try writer_iface.flush();
        std.log.info("Configuration file successfuly created. Please complet them and restart the macro", .{});
        std.process.exit(0);
    }

    pub fn load_config(self: *@This()) !void {
        const file = try std.Io.Dir.openFileAbsolute(self.io, self.cfgfile, .{ .mode = .read_only });
        defer file.close(self.io);
        const filesize = try file.length(self.io);
        const buffer = try self.allocator.alloc(u8, 4096);
        defer self.allocator.free(buffer);
        var fr = file.reader(self.io, buffer);
        self.filebuf = try self.allocator.realloc(self.filebuf, filesize);
        fr.interface.readSliceAll(self.filebuf) catch |err| {
            return err;
        };
        var list: std.ArrayList(u8) = .empty;
        defer list.deinit(self.allocator);

        var idx = std.mem.find(u8, self.filebuf, "[rld]>");
        idx.? += 6;
        for (self.filebuf[idx.?..]) |byte| blk: {
            if (byte == '<') break :blk;
            try list.append(self.allocator, byte);
        }
        self.roblox_log_dir = try list.toOwnedSlice(self.allocator);
        self.roblox_log_dir = try self.allocator.realloc(self.roblox_log_dir, self.roblox_log_dir.len - 1);
        std.log.info("Configuration successfuly loaded", .{});
    }

    pub fn deinit(self: *@This()) void {
        self.allocator.free(self.cfgfile);
        self.allocator.free(self.filebuf);
        self.allocator.free(self.roblox_log_dir);
        std.log.info("Deinited configurator", .{});
    }
};
