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

const Cell = struct {
    x: usize,
    y: usize,


    pub fn init (x: usize, y: usize) Cell {
        return . {
            .x = x,
            .y = y,
        };
    }
};

// Returns a cell struct of the next empty cell if it return null board is solved
pub fn find_empty(sudoku_board: Board) ?Cell {
    for(0..9) |i| {
        for(0..9) |j| {
            if(sudoku_board.cells[i * 9 + j] == 0) {
                return (Cell.init(i, j));
            }
        }
    }

    return null;
    }