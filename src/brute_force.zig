const board = @import("board.zig");
const Board = board.Board;


// brute force method of solving the sudoku
pub fn brute_force(sudoku_board: *Board) bool {

    // Base case, board is solved 
    if (filled(sudoku_board.*)) {
        return;
    }


}

// returns true if solved and false otherwise
pub fn filled(sudoku_board: Board) bool {
    for (0..81) |i| {
        if (sudoku_board.cells[i] == 0) {
            return false;
        }
    }
    return true;
}