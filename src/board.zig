const board = struct {
    cells: [81]u8,
    num_occupied: u8,
    
    // Returns the number at a position on the grid
    pub fn at(self: board, x: u8, y: u8) u8 {
        return self.cells[y*9 + x];  
    }

    // Setter for the cells of the board
    pub fn set(self: *board, x: u8, y: u8, val: u8) void {
        self.cells[y*9 + x] = val;
    }


};