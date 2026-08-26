const std = @import("std");

const PyHandler = struct {
    allocator: std.mem.Allocator,
    io: std.Io,
    argv: [][]const u8,

    pub fn init(io: std.Io, gpa: std.mem.Allocator, argv: [][]const u8) @This() {
        return .{
            .allocator = gpa,
            .io = io,
            .argv = argv,
        };
    }
};
