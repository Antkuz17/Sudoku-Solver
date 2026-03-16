const board = @import("board.zig");
const Board = board.Board;


// brute force method of solving the sudoku
pub fn brute_force(sudoku_board: *Board) bool {

    const next_cell = find_empty(sudoku_board.*);

    // Base case, board is solved 
    if (next_cell == null) {
        return true;
    }

    const cell = next_cell.?;

    for (1..10) |i| {
        if (sudoku_board.is_valid(cell.x, cell.y, @intCast(i))) {
            sudoku_board.cells[cell.y * 9 + cell.x] = @intCast(i);
            if (brute_force(sudoku_board)) {
                return true;
            }
            sudoku_board.cells[cell.y * 9 + cell.x] = 0;
        }
    }
    
    return false;
    




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
                return (Cell.init(j, i));
            }
        }
    }

    return null;
    }