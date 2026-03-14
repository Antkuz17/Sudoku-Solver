const board = struct {
    cells: [81]u8,
    
    // Returns the number at a position on the grid
    pub fn at(self: board, x: u8, y: u8) u8 {
        return self.cells[y*9 + x];  
    }


    // Returns whether or not given a position and value if its valid, if there a val there return false
    pub fn is_valid(self: board, x: usize, y: usize, val: u8) bool {

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

    // Goes through and zeros the entire board
    pub fn zero(self: *board) void {
        for (0..81) |i| {
            self.cells[i] = 0;
        }
    }

};