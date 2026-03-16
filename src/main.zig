const std = @import("std");
const board = @import("board.zig");
const Board = board.Board;

const brute_force = @import("brute_force.zig");
const mrv = @import("mrv.zig");

pub fn main() !void {
    var test1 = Board.init();
    apply_Board_1(&test1);
    test1.print();

    _ = mrv.mrv(&test1);

    test1.print();


}

// known wikipedia pattern, 1 unique solution
pub fn apply_Board_1(test1: *Board) void {
    test1.set(0, 0, 5);
    test1.set(1, 0, 3);
    test1.set(4, 0, 7);
    test1.set(0, 1, 6);
    test1.set(3, 1, 1);
    test1.set(4, 1, 9);
    test1.set(5, 1, 5);
    test1.set(1, 2, 9);
    test1.set(2, 2, 8);
    test1.set(7, 2, 6);
    test1.set(0, 3, 8);
    test1.set(4, 3, 6);
    test1.set(8, 3, 3);
    test1.set(0, 4, 4);
    test1.set(3, 4, 8);
    test1.set(5, 4, 3);
    test1.set(8, 4, 1);
    test1.set(0, 5, 7);
    test1.set(4, 5, 2);
    test1.set(8, 5, 6);
    test1.set(1, 6, 6);
    test1.set(6, 6, 2);
    test1.set(7, 6, 8);
    test1.set(3, 7, 4);
    test1.set(4, 7, 1);
    test1.set(5, 7, 9);
    test1.set(8, 7, 5);
    test1.set(4, 8, 8);
    test1.set(7, 8, 7);
    test1.set(8, 8, 9);
}