const std = @import("std");
const cfgu = @import("configurator.zig");
const lg = @import("log.zig");
const ph = @import("pyhandler.zig"); // Calm down its just PyHandler

pub fn main(init: std.process.Init) !void {
    std.log.info("Macro started !", .{});
    var s_cfg = try cfgu.configurator.init(init.io, init.gpa, init.environ_map);
    var s_py = try ph.PyHandler.init(init.io, init.gpa, "python/main.py", "biome");
    std.log.info("s_cfg ({s}) and s_py ({s}) initialized", .{ @typeName(@TypeOf(s_cfg)), @typeName(@TypeOf(s_py)) });

    defer s_py.deinit();
    defer s_cfg.deinit();
    std.log.info("defer deinit of s_py and s_cfg", .{});

    var biome: ?[]const u8 = null;
    var last_biome: []u8 = try init.gpa.alloc(u8, 1);
    defer init.gpa.free(last_biome);
    var exist = true;
    std.Io.Dir.accessAbsolute(init.io, s_cfg.cfgfile, .{}) catch |e| {
        switch (e) {
            error.FileNotFound => exist = false,
            else => exist = true,
        }
    };
    if (exist) {
        std.log.info("Load config", .{});
        try s_cfg.load_config();
    } else {
        std.log.info("Create Config", .{});
        try s_cfg.create_config();
    }
    var s_log = try lg.logger.init(init.io, init.gpa, s_cfg.roblox_log_dir);
    std.log.info("s_log ({s}) initialized", .{@typeName(@TypeOf(s_log))});
    defer s_log.deinit();
    std.log.info("defer deinit s_log", .{});
    std.log.debug("{s}", .{s_log.full_path});
    _ = try s_log._readfile(s_log.full_path);
    std.log.debug("----------------\n", .{});
    while (!s_log.check_leave()) {
        biome = try s_log.extractbiome(try s_log._readfile(s_log.full_path));
        std.log.info("biome {s} extracted", .{biome.?});
        if (!std.mem.eql(u8, biome.?, last_biome)) {
            std.log.info("New biome detected !", .{});
            try s_py.changeargv(biome.?);
            try s_py.execute();
            std.log.info("Embed send", .{});
            init.gpa.free(last_biome);
            last_biome = try init.gpa.dupe(u8, biome.?);
        }
    }
}
