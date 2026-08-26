const std = @import("std");

pub const EError = enum {
    LogsDontContains,
    LenReachedDestLen,
    HomeVariableEnvironnementDontExist,
};

const _errortab = std.EnumArray(EError, []const u8).init(.{
    .LogsDontContains = "Logs dont contains the researched word",
    .LenReachedDestLen = "The len is superior or equal then dest.len",
    .HomeVariableEnvironnementDontExist = "The variable HOME or USERPROFILE doesnt exit",
});

pub fn print_error(eerr: EError, note: []const u8, exit: bool) void {
    std.debug.print("ERROR: {s}\n", .{_errortab.get(eerr)});
    std.debug.print("Developper note: {s}\n", .{note});
    if (exit) std.process.exit(1);
}
