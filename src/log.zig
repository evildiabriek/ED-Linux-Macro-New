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
            .full_path = try std.fmt.allocPrint(gpa, "{s}{s}", .{ logpath, "latest.log" }),
            .vectorbuf = undefined,
            .filebuf = try gpa.alloc(u8, 1),
            .biome = try gpa.alloc(u8, 1),
        };
    }

    fn _strncpy_delim(dest: []u8, src: string, delim: u8, len: usize) !usize {
        //if (len > dest.len) EErr.print_error(EErr.EError.LenReachedDestLen, "-", true);
        var idx: usize = 0;
        blk: for (src, 0..len) |chr, _| {
            if (chr == delim) break :blk;
            dest[idx] = src[idx];
            idx += 1;
        }
        return idx;
    }

    pub fn _readfile(self: *@This(), filepath: string) !string {
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
        const join = std.mem.findLast(u8, self.filebuf, "place 15532962292");
        //std.log.info("Check if the player is on the game...", .{});
        if (join == null) {
            EErr.print_error(EErr.EError.LogsDontContains, "Logs can crash, restart your client", true);
            return true;
        }
        if (leave == null) {
            //std.log.info("Player never leave", .{});
            return false;
        }
        if (join.? > leave.?) {
            //std.log.info("Player is on game !", .{});
            return false;
        }
        //std.log.info("Player leave", .{});
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
            self.allocator.free(self.biome);
            self.biome = try self.allocator.alloc(u8, 200);
            const src = str[last_idx.? + 1 ..];
            const maxsize = try _strncpy_delim(self.biome, src, '"', src.len);
            self.biome = try self.allocator.realloc(self.biome, maxsize);
            //std.log.info("Biome detected: {s}", .{self.biome});
            return self.biome;
        }
        EErr.print_error(EErr.EError.LogsDontContains, "Logs maybe crash, restart your client", true);
        return "for exemple: nothing";
    }

    //pub fn extractmerchant(self: *@This(), str: string) !bool {}

    pub fn deinit(self: *@This()) void {
        self.allocator.free(self.filebuf);
        self.allocator.free(self.biome);
        self.allocator.free(self.full_path);
        std.log.info("Deinited logger", .{});
    }
};
