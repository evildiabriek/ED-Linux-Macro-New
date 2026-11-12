const std = @import("std");
const cfgu = @import("configurator.zig");
const lg = @import("log.zig");
const ph = @import("pyhandler.zig"); // Calm down its just PyHandler
const zlib = @import("Zlib");

pub fn main(init: std.process.Init) !void {
    std.log.info("Macro started !", .{}); // Log for say macro starting
    var s_cfg = try cfgu.configurator.init(init.io, init.gpa, init.environ_map); // Init the configurator, for read the config file with webhook, ps link etc...
    var s_py = try ph.PyHandler.init(init.io, init.gpa, "python/main.py", "biome"); // PyHandler for execute the python file. Used for send embed
    std.log.info("s_cfg ({s}) and s_py ({s}) initialized", .{ @typeName(@TypeOf(s_cfg)), @typeName(@TypeOf(s_py)) }); // Say what is initialized

    defer s_py.deinit();
    defer s_cfg.deinit();
    std.log.info("defer deinit of s_py and s_cfg", .{}); // log

    var biome: ?[]const u8 = null; // Biome var, initialized at null
    var last_biome: []u8 = try init.gpa.alloc(u8, 1); // Last biome, for send only new biome
    defer init.gpa.free(last_biome); // free, for free the memory. If i dont do that -> memory leak
    var exist = true; // If config file exist
    std.Io.Dir.accessAbsolute(init.io, s_cfg.cfgfile, .{}) catch |e| {
        switch (e) {
            error.FileNotFound => exist = false,
            else => exist = true,
        }
    };
    if (exist) { // if exist -> load | if not -> create
        std.log.info("Load config", .{});
        try s_cfg.load_config();
    } else {
        std.log.info("Create Config", .{});
        try s_cfg.create_config();
    }
    var s_log = try lg.logger.init(init.io, init.gpa, s_cfg.roblox_log_dir); // Init the logger handler
    std.log.info("s_log ({s}) initialized", .{@typeName(@TypeOf(s_log))});
    defer s_log.deinit();
    std.log.info("defer deinit s_log", .{});
    _ = try s_log._readfile(s_log.full_path); // read the log file
    while (!s_log.check_leave()) { // Stop if you leave your server
        biome = try init.gpa.dupe(u8, try s_log.extractbiome(try s_log._readfile(s_log.full_path))); // dupe = copy (bc in C/Zig... string are not string: its a array of simple char)
        if (!std.mem.eql(u8, biome.?, last_biome)) { // Comparing (this word exist ?) last biome and biome (bc the while work ~1 000 000/s)
            std.log.info("biome {s} extracted", .{biome.?}); // New biome !
            std.log.info("New biome detected !", .{});
            try s_py.changeargv(biome.?); // Change argv for the biome (argv = argument)
            try s_py.execute(); // Execute the Python file
            std.log.info("Embed send", .{}); // Log
            init.gpa.free(last_biome); // Free last biome for get a new variable with clean memory
            last_biome = try init.gpa.dupe(u8, biome.?); // redupe the biome var
        }
        init.gpa.free(biome.?); // free the biome
    }
}
