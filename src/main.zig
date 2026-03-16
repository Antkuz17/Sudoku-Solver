const std = @import("std");
const board_mod = @import("board.zig");
const Board = board_mod.Board;
const brute_force_mod = @import("brute_force.zig");
const mrv_mod = @import("mrv.zig");
const propagation_mod = @import("propagation.zig");

const windows = @cImport({
    @cInclude("windows.h");
});


fn puzzle_easy_1(b: *Board) void {
    b.set(0, 0, 5); b.set(1, 0, 3); b.set(4, 0, 7);
    b.set(0, 1, 6); b.set(3, 1, 1); b.set(4, 1, 9); b.set(5, 1, 5);
    b.set(1, 2, 9); b.set(2, 2, 8); b.set(7, 2, 6);
    b.set(0, 3, 8); b.set(4, 3, 6); b.set(8, 3, 3);
    b.set(0, 4, 4); b.set(3, 4, 8); b.set(5, 4, 3); b.set(8, 4, 1);
    b.set(0, 5, 7); b.set(4, 5, 2); b.set(8, 5, 6);
    b.set(1, 6, 6); b.set(6, 6, 2); b.set(7, 6, 8);
    b.set(3, 7, 4); b.set(4, 7, 1); b.set(5, 7, 9); b.set(8, 7, 5);
    b.set(4, 8, 8); b.set(7, 8, 7); b.set(8, 8, 9);
}

fn puzzle_easy_2(b: *Board) void {
    b.set(0, 0, 1); b.set(3, 0, 4); b.set(6, 0, 7);
    b.set(1, 1, 2); b.set(4, 1, 5); b.set(7, 1, 8);
    b.set(2, 2, 3); b.set(5, 2, 6); b.set(8, 2, 9);
    b.set(0, 3, 4); b.set(3, 3, 7); b.set(6, 3, 1);
    b.set(1, 4, 5); b.set(4, 4, 8); b.set(7, 4, 2);
    b.set(2, 5, 6); b.set(5, 5, 9); b.set(8, 5, 3);
    b.set(0, 6, 7); b.set(3, 6, 1); b.set(6, 6, 4);
    b.set(1, 7, 8); b.set(4, 7, 2); b.set(7, 7, 5);
    b.set(2, 8, 9); b.set(5, 8, 3); b.set(8, 8, 6);
}

fn puzzle_medium_1(b: *Board) void {
    b.set(0, 0, 4); b.set(6, 0, 8); b.set(8, 0, 5);
    b.set(1, 1, 3); b.set(4, 1, 2);
    b.set(3, 2, 6); b.set(5, 2, 5); b.set(7, 2, 1);
    b.set(0, 3, 8); b.set(3, 3, 1); b.set(6, 3, 3);
    b.set(2, 4, 6); b.set(4, 4, 8); b.set(6, 4, 7);
    b.set(2, 5, 3); b.set(5, 5, 6); b.set(8, 5, 1);
    b.set(1, 6, 5); b.set(3, 6, 7); b.set(5, 6, 2);
    b.set(4, 7, 1); b.set(7, 7, 4);
    b.set(0, 8, 3); b.set(2, 8, 2); b.set(8, 8, 7);
}

fn puzzle_medium_2(b: *Board) void {
    b.set(1, 0, 7); b.set(4, 0, 2); b.set(7, 0, 4);
    b.set(0, 1, 5); b.set(5, 1, 8); b.set(8, 1, 3);
    b.set(2, 2, 4); b.set(3, 2, 7); b.set(6, 2, 1);
    b.set(0, 3, 3); b.set(4, 3, 6); b.set(8, 3, 9);
    b.set(2, 4, 8); b.set(6, 4, 5);
    b.set(0, 5, 6); b.set(4, 5, 3); b.set(8, 5, 7);
    b.set(2, 6, 5); b.set(5, 6, 7); b.set(6, 6, 3);
    b.set(0, 7, 4); b.set(3, 7, 2); b.set(8, 7, 6);
    b.set(1, 8, 2); b.set(4, 8, 9); b.set(7, 8, 1);
}

fn puzzle_hard_1(b: *Board) void {
    b.set(0, 0, 8);
    b.set(2, 1, 3); b.set(3, 1, 6);
    b.set(1, 2, 7); b.set(4, 2, 9); b.set(6, 2, 2);
    b.set(1, 3, 5); b.set(5, 3, 7);
    b.set(4, 4, 4); b.set(5, 4, 5); b.set(6, 4, 7);
    b.set(3, 5, 1); b.set(7, 5, 3);
    b.set(2, 6, 1); b.set(7, 6, 6); b.set(8, 6, 8);
    b.set(2, 7, 8); b.set(3, 7, 5); b.set(7, 7, 1);
    b.set(1, 8, 9); b.set(6, 8, 4);
}

fn puzzle_hard_2(b: *Board) void {
    b.set(5, 0, 3); b.set(7, 0, 8); b.set(8, 0, 5);
    b.set(2, 1, 1); b.set(5, 1, 2);
    b.set(3, 2, 4); b.set(8, 2, 1);
    b.set(1, 3, 4); b.set(5, 3, 1); b.set(7, 3, 2);
    b.set(0, 4, 6); b.set(6, 4, 7);
    b.set(1, 5, 5); b.set(3, 5, 9); b.set(7, 5, 4);
    b.set(0, 6, 4); b.set(5, 6, 7);
    b.set(3, 7, 6); b.set(6, 7, 1);
    b.set(0, 8, 8); b.set(1, 8, 2); b.set(3, 8, 5);
}

fn puzzle_expert_1(b: *Board) void {
    b.set(0, 0, 1); b.set(6, 0, 3);
    b.set(2, 1, 6); b.set(4, 1, 2); b.set(8, 1, 7);
    b.set(1, 2, 5); b.set(7, 2, 9);
    b.set(0, 3, 7); b.set(5, 3, 5); b.set(8, 3, 6);
    b.set(3, 4, 3); b.set(5, 4, 8);
    b.set(0, 5, 6); b.set(3, 5, 2); b.set(8, 5, 4);
    b.set(1, 6, 4); b.set(7, 6, 7);
    b.set(0, 7, 9); b.set(4, 7, 8); b.set(6, 7, 1);
    b.set(2, 8, 5); b.set(8, 8, 2);
}

fn puzzle_expert_2(b: *Board) void {
    b.set(8, 0, 3);
    b.set(0, 1, 6); b.set(5, 1, 5); b.set(7, 1, 9);
    b.set(1, 2, 8); b.set(6, 2, 7);
    b.set(0, 3, 3); b.set(4, 3, 4); b.set(7, 3, 6);
    b.set(2, 4, 6); b.set(6, 4, 2);
    b.set(1, 5, 9); b.set(4, 5, 8); b.set(8, 5, 7);
    b.set(2, 6, 5); b.set(7, 6, 4);
    b.set(1, 7, 3); b.set(3, 7, 9); b.set(8, 7, 6);
    b.set(0, 8, 4);
}

fn bench(comptime name: []const u8, comptime solver: fn (*Board) bool, b: *Board) void {
    var start: windows.LARGE_INTEGER = undefined;
    var end: windows.LARGE_INTEGER = undefined;
    _ = windows.QueryPerformanceCounter(&start);
    _ = solver(b);
    _ = windows.QueryPerformanceCounter(&end);
    const elapsed = end.QuadPart - start.QuadPart;
    std.debug.print("{s:<20} | {d:>10} ticks\n", .{ name, elapsed });
}

pub fn main() !void {
    const puzzles = [_]struct {
        name: []const u8,
        setup: *const fn (*Board) void,
    }{
        .{ .name = "Easy 1",    .setup = puzzle_easy_1 },
        .{ .name = "Easy 2",    .setup = puzzle_easy_2 },
        .{ .name = "Medium 1",  .setup = puzzle_medium_1 },
        .{ .name = "Medium 2",  .setup = puzzle_medium_2 },
        .{ .name = "Hard 1",    .setup = puzzle_hard_1 },
        .{ .name = "Hard 2",    .setup = puzzle_hard_2 },
        .{ .name = "Expert 1",  .setup = puzzle_expert_1 },
        .{ .name = "Expert 2",  .setup = puzzle_expert_2 },
    };

    std.debug.print("{s:<20} | {s:>10}    | {s:>8}\n", .{ "Puzzle", "Time (ns)", "Time (us)" });
    std.debug.print("{s}\n", .{"-" ** 50});

    for (puzzles) |puzzle| {
        std.debug.print("\n--- {s} ---\n", .{puzzle.name});

        var b1 = Board.init();
        puzzle.setup(&b1);
        bench("Brute Force", brute_force_mod.brute_force, &b1);

        var b2 = Board.init();
        puzzle.setup(&b2);
        bench("MRV", mrv_mod.mrv, &b2);

        var b3 = Board.init();
        puzzle.setup(&b3);
        b3.initialize_candidates();
        bench("Propagation", propagation_mod.propagation, &b3);
    }
}