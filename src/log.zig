const std = @import("std");
const string = []const u8;
const EErr = @import("error.zig");

pub const logger = struct {
    allocator: std.mem.Allocator,
    io: std.Io,
    full_path: string,
    vectorbuf: [4096]u8,
    filebuf: []u8,
    biome: []u8,

    pub fn init(io: std.Io, gpa: std.mem.Allocator, logpath: string) !@This() {
        std.log.info("Inited logger", .{});
        return .{
            .allocator = gpa,
            .io = io,
            .full_path = logpath,
            .vectorbuf = undefined,
            .filebuf = try gpa.alloc(u8, 1),
            .biome = try gpa.alloc(u8, 1),
        };
    }

    fn _strncpy_delim(_: @This(), dest: []u8, src: string, delim: u8, len: usize) !void {
        if (len >= dest.len) EErr.print_error(EErr.EError.LenReachedDestLen, "-", true);
        blk: for (src, 0..len) |chr, idx| {
            if (chr == delim) break :blk;
            dest[idx] = src[idx];
        }
    }

    fn _readfile(self: *@This(), filepath: string) !string {
        const file = try std.Io.Dir.openFileAbsolute(self.io, filepath, .{ .mode = .read_only });
        defer file.close(self.io);
        const filesize = try file.length(self.io);
        const buffer = try self.allocator.alloc(u8, 4096);
        defer self.allocator.free(buffer);
        var fr = file.reader(self.io, buffer);
        self.filebuf = try self.allocator.realloc(self.filebuf, filesize);
        fr.interface.readSliceAll(self.filebuf) catch |err| {
            return err;
        };
        return self.filebuf;
    }

    pub fn check_leave(self: *@This()) bool {
        const leave = std.mem.findLast(u8, self.filebuf, "DisconnectClientInitiated");
        const join = std.mem.findLast(u8, self.filebuf, "Joining game '30aee394-bcef-4f38-bda5-fb21ccb455fb' place 15532962292");
        std.log.info("Check if the player is on the game...");
        if (leave == null) return false;
        if (join == null) {
            EErr.print_error(EErr.EError.LogsDontContains, "Logs can crash, restart your client", true);
            return true;
        }
        if (join.? > leave.?) return false;
        return true;
    }

    pub fn extractbiome(self: *@This(), str: string) !string {
        if (std.mem.findLast(u8, str, "largeImage")) |idx| blk: {
            var last_idx = std.mem.findPos(u8, str, idx, "hoverText");
            if (last_idx == null) break :blk;
            last_idx = std.mem.findScalarPos(u8, str, last_idx.?, ':');
            if (last_idx == null) break :blk;
            last_idx = std.mem.findScalarPos(u8, str, last_idx.?, '"');
            if (last_idx == null) break :blk;
            self.biome = try self.allocator.realloc(self.biome, 4096);
            const src = str[last_idx.? + 1 ..];
            try _strncpy_delim(self.biome, src, '"', src.len);
            std.log.info("Biome detected: {s}", .{self.biome});
            return self.biome;
        }
        EErr.print_error(EErr.EError.LogsDontContains, "Logs maybe crash, restart your client", true);
        return "for exemple: nothing";
    }

    pub fn deinit(self: *@This()) void {
        self.allocator.free(self.filebuf);
        self.allocator.free(self.biome);
        std.log.info("Deinited logger", .{});
    }
};
