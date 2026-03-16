const std = @import("std");

pub const Board = struct {
    cells: [81]u8,

    // bitwise rep of all cells on the board
    candidates: [81]u9,
    

    // Initlizer for the Board struct, by default returns a Board with all zero'ed val's
    pub fn init () Board {
        return . {
            .cells =  [_]u8{0} ** 81,
        };
    }

    // Go through board array and set the bits for each position
    pub fn initialize_candidates(self: *Board) void {
        for (0..81) |i| {

            // Converting back to x y
            const x = i % 9;
            const y = i / 9;

            // If the current cell has a val, no need for bit mask
            if(self.cells[i] != 0) {
                continue;
            }

            // go through each val and see if valid, if so, set the bit
            for (1..10) |j| {
                if(self.is_valid(x, y, @intCast(j))){
                    self.candidates[i] |= @as(u9, 1) << @intCast(j);
                }
            }
        }
    }



    // Returns the number at a position on the grid
    pub fn at(self: Board, x: u8, y: u8) u8 {
        return self.cells[y*9 + x];  
    }


    // Returns whether or not given a position and value if its valid, if there a val there return false
    pub fn is_valid(self: Board, x: usize, y: usize, val: u8) bool {

        // If cell not empty return false
        if (self.cells[y * 9 + x] != 0) {
            return false;
        }

        // Check row
        for (0..9) |i| {
            if (self.cells[y * 9 + i] == val) return false;
        }

        // Check column
        for (0..9) |i| {
            if (self.cells[i * 9 + x] == val) return false;
        }

        // Check 3x3 box
        const box_x = (x / 3) * 3;
        const box_y = (y / 3) * 3;
        for (0..3) |i| {
            for (0..3) |j| {
                if (self.cells[(box_y + i) * 9 + (box_x + j)] == val) return false;
            }
        }

        return true;
    }

    // Goes through and zeros the entire Board
    pub fn zero(self: *Board) void {
        for (0..81) |i| {
            self.cells[i] = 0;
        }
    }

    // Returns false if cell empty and true otherwise
    pub fn empty(self: Board, x: u8, y: u8) bool {
        if (self.cells[y*9 + x] == 0) {
            return true;
        }
        return false;
    }

    // Sets a position on the grid to the input number
    pub fn set(self: *Board, x: u8, y: u8, input: u8) void {
        self.cells[y*9 + x] = input;
    }   


    pub fn print(self: Board) void {
        for (0..9) |row| {
            if (row % 3 == 0) {
                std.debug.print("+-------+-------+-------+\n", .{});
            }
            for (0..9) |col| {
                if (col % 3 == 0) {
                    std.debug.print("| ", .{});
                }
                const val = self.cells[row * 9 + col];
                if (val == 0) {
                    std.debug.print(". ", .{});
                } else {
                    std.debug.print("{d} ", .{val});
                }
            }
            std.debug.print("|\n", .{});
        }
        std.debug.print("+-------+-------+-------+\n", .{});
    }

};