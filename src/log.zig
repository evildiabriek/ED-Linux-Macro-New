const std = @import("std");
const string = []const u8;

pub const logger = struct {
    full_path: []const u8,
    vectorbuf: [4096]u8,
    filebuf: []u8,
    io: std.Io,
    allocator: std.mem.Allocator,

    pub fn init(io: std.Io, gpa: std.mem.Allocator) @This() {
        return .{
            .allocator = gpa,
            .io = io,
            .full_path = undefined,
            .vectorbuf = undefined,
            .filebuf = undefined,
        };
    }

    pub fn _readfile(self: *@This(), filepath: string) !string {
        const cwd = std.Io.Dir.cwd();
        const file = try cwd.openFile(self.io, filepath, .{ .mode = .read_only });
        defer file.close(self.io);
        const filesize = try file.length(self.io);
        const buffer = try self.allocator.alloc(u8, 4096);
        defer self.allocator.free(buffer);
        var fr = file.reader(self.io, buffer);
        self.filebuf = try self.allocator.alloc(u8, filesize);
        fr.interface.readSliceAll(self.filebuf) catch |err| {
            return err;
        };
        return self.filebuf;
    }

    pub fn deinit(self: *@This()) void {
        self.allocator.free(self.filebuf);
    }
};
