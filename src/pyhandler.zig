const std = @import("std");
const builtin = @import("builtin");
const EErr = @import("error.zig");

pub const PyHandler = struct {
    allocator: std.mem.Allocator,
    io: std.Io,
    argv: []const u8,
    scriptname: []const u8,
    proc: std.process.Child,

    pub fn init(io: std.Io, gpa: std.mem.Allocator, srciptname: []const u8, argv: []const u8) !@This() {
        std.log.info("Inited PyHandler", .{});
        return .{
            .allocator = gpa,
            .io = io,
            .argv = try gpa.dupe(u8, argv),
            .scriptname = try gpa.dupe(u8, srciptname),
            .proc = undefined,
        };
    }

    pub fn execute(self: *@This()) !void {
        _ = std.Io.Dir.openDir(std.Io.Dir.cwd(), self.io, ".venv", .{}) catch |e| {
            switch (e) {
                error.FileNotFound => EErr.print_error(EErr.EError.VenvDoesntExist, "-", true),
                else => std.log.err("Other err: {any}", .{e}),
            }
        };
        const pyname = switch (builtin.os.tag) {
            .windows => "python",
            else => "python3",
        };
        const argv: [3][]const u8 = .{
            try std.fmt.allocPrint(self.allocator, "{s}{s}", .{ ".venv/bin/", pyname }), self.scriptname, self.argv,
        };
        std.log.debug("Execute: {s} {s} {s}", .{ argv[0], argv[1], argv[2] });
        self.proc = try std.process.spawn(self.io, .{ .argv = &argv });
        _ = try self.proc.wait(self.io);
        self.allocator.free(argv[0]);
    }

    pub fn changeargv(self: *@This(), new_argv: []const u8) !void {
        self.allocator.free(self.argv);
        self.argv = try self.allocator.dupe(u8, new_argv);
        std.log.info("Change argv for {s}", .{new_argv});
    }

    pub fn changeScriptName(self: *@This(), new_scriptname: []const u8) void {
        self.allocator.free(self.scriptname);
        self.scriptname = self.allocator.dupe(u8, new_scriptname);
        std.log.info("Change argv for {s}", .{new_scriptname});
    }

    pub fn deinit(self: *@This()) void {
        self.allocator.free(self.scriptname);
        self.allocator.free(self.argv);
        std.log.info("Dinited PyHandler", .{});
    }
};
