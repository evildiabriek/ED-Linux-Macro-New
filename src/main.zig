const std = @import("std");
const cfgu = @import("configurator.zig");
const lg = @import("log.zig");
pub fn main(init: std.process.Init) !void {
    var c = try cfgu.configurator.init(init.io, init.gpa, init.environ_map);
    defer c.deinit();
    var exist = true;
    std.Io.Dir.accessAbsolute(init.io, c.cfgfile, .{}) catch |e| {
        switch (e) {
            error.FileNotFound => exist = false,
            else => exist = true,
        }
    };
    if (exist) {
        std.log.info("Load config", .{});
        try c.load_config();
    } else {
        std.log.info("Create Config\n", .{});
        try c.create_config();
    }
    var l = try lg.logger.init(init.io, init.gpa, c.roblox_log_dir);
    defer l.deinit();
}
