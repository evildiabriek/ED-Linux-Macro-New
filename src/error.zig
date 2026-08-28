const std = @import("std");

pub const EError = enum {
    LogsDontContains,
    LenReachedDestLen,
    HomeVariableEnvironnementDontExist,
    RobloxLogDirNotValide,
    VenvDoesntExist,
};

const _errortab = std.EnumArray(EError, []const u8).init(.{
    .LogsDontContains = "Logs dont contains the researched word",
    .LenReachedDestLen = "The len is superior or equal then dest.len",
    .HomeVariableEnvironnementDontExist = "The variable HOME or USERPROFILE doesnt exit",
    .RobloxLogDirNotValide = "Logs dont contain obligatoire charactere (/ or \\)",
    .VenvDoesntExist = "PyHandler need a venv at path '.venv'",
});

pub fn print_error(eerr: EError, note: []const u8, exit: bool) void {
    std.log.err("ERROR: {s}", .{_errortab.get(eerr)});
    std.log.err("Developper note: {s}", .{note});
    if (exit) std.process.exit(1);
}
