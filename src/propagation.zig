const board = @import("board.zig");
const Board = board.Board;


// brute force method of solving the sudoku
pub fn propagation(sudoku_board: *Board) bool {

    const next_cell = find_most_constrained(sudoku_board.*);

    // Base case, board is solved 
    if (next_cell == null) {
        return true;
    }

    const cell = next_cell.?;

    for (1..10) |i| {
        if (sudoku_board.is_valid(cell.x, cell.y, @intCast(i))) {
            sudoku_board.cells[cell.y * 9 + cell.x] = @intCast(i);
            if (propagation(sudoku_board)) {
                return true;
            }
            sudoku_board.cells[cell.y * 9 + cell.x] = 0;
        }
    }
    
    return false;


}

// Only touches the candidates list no modifying the board
pub fn propagate(sudoku_board: *Board, x: usize, y: usize) bool {
    const current_val: u8 = sudoku_board.cells[y * 9 + x];
    const bit: u9 = @as(u9, 1) << @intCast(current_val);

    // Remove this value from all peers in the same row
    for (0..9) |i| {
        if (i == x) continue;
        const idx = y * 9 + i;
        sudoku_board.candidates[idx] &= ~bit;
        if (sudoku_board.cells[idx] != 0) continue;
        if (sudoku_board.candidates[idx] == 0) return false;
        if (@popCount(sudoku_board.candidates[idx]) == 1) {
            const forced_val = @ctz(sudoku_board.candidates[idx]);
            sudoku_board.cells[idx] = @intCast(forced_val);
            if (!propagate(sudoku_board, i, y)) return false;
        }
    }

    // Remove from column
    for (0..9) |i| {
        if (i == y) continue;
        const idx = i * 9 + x;
        sudoku_board.candidates[idx] &= ~bit;
        if (sudoku_board.cells[idx] != 0) continue;
        if (sudoku_board.candidates[idx] == 0) return false;
        if (@popCount(sudoku_board.candidates[idx]) == 1) {
            const forced_val = @ctz(sudoku_board.candidates[idx]);
            sudoku_board.cells[idx] = @intCast(forced_val);
            if (!propagate(sudoku_board, x, i)) return false;
        }
    }

    // Remove from 3x3 box
    const box_x = (x / 3) * 3;
    const box_y = (y / 3) * 3;
    for (0..3) |i| {
        for (0..3) |j| {
            const px = box_x + j;
            const py = box_y + i;
            if (px == x and py == y) continue;
            const idx = py * 9 + px;
            sudoku_board.candidates[idx] &= ~bit;
            if (sudoku_board.cells[idx] != 0) continue;
            if (sudoku_board.candidates[idx] == 0) return false;
            if (@popCount(sudoku_board.candidates[idx]) == 1) {
                const forced_val = @ctz(sudoku_board.candidates[idx]);
                sudoku_board.cells[idx] = @intCast(forced_val);
                if (!propagate(sudoku_board, px, py)) return false;
            }
        }
    }

    return true;
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
pub fn find_most_constrained(sudoku_board: Board) ?Cell {

    var num_most_constrained: usize = 10;    
    var current_count: usize = 0; 
    var x: usize = 0;
    var y: usize = 0;

    for(0..9) |i| {
        for(0..9) |j| {
            if (sudoku_board.cells[i * 9 + j] != 0) continue;
            for(1..10) |z| {
                if(sudoku_board.is_valid(j, i, @intCast(z))) {
                    current_count += 1;
                }
            }
            if(current_count == 1) {
                return Cell.init(j, i);
            }
            if (current_count < num_most_constrained) {
                num_most_constrained = current_count;
                x = j;
                y = i;
            }
            current_count = 0;
        }
    }

    if (num_most_constrained == 10) return null;
    return Cell.init(x, y);
}