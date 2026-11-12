const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const opti = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "EDmacro",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = opti,
        }),
    });
    b.installArtifact(exe);
    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run-macro", "Run the macro");
    run_step.dependOn(&run_exe.step);
}
