require_relative "piece"
require 'byebug' 

class Board
    attr_accessor :board
    
    def initialize
        @board = Array.new(8) { Array.new(8) }
        populate
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @board[row][col] = piece
    end

    def move_piece(start_pos, end_pos)
        start_piece = self[start_pos]
        end_piece = self[end_pos]
        raise "There is no piece at that position" if start_piece.is_a?(NullPiece)
        if end_piece.color == start_piece.color
            raise "Friendly fire!"
        elsif end_piece.is_a?(NullPiece)
            start_piece.pos = end_pos
            end_piece.pos = start_pos
            start_piece, end_piece = end_piece, start_piece
        elsif start_piece.color != end_piece.color && !end_piece.is_a?(NullPiece)
            start_piece.pos = end_pos
            self[end_pos] = start_piece
            self[start_pos] = NullPiece.new(start_pos)
        end

    end

    def self.valid_pos?(pos)
        a, b = pos
        (0..7).include?(a) && (0..7).include?(b)
    end


    def populate
        @board.each_index do |row|
            @board.each_index do |col|
                if row == 0 || row == 1
                    @board[row][col] = Piece.new([row,col], :white)
                elsif row == 6 || row == 7
                    @board[row][col] = Piece.new([row,col], :black)
                else
                    @board[row][col] = NullPiece.new([row,col])
                end
            end
        end
    end

    

end