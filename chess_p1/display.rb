require_relative "cursor"
require_relative "board"

require "colorize"
class Display
    attr_reader :board, :cursor

    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
    end

    def render
        @board.board.each_with_index do |row, idx1|
            row_view = []
            row.each_with_index do |piece, idx2|
                if piece.is_a?(NullPiece)
                    if [idx1, idx2] != @cursor.cursor_pos
                        row_view << :empty.to_s
                    else
                        row_view << :empty.to_s.colorize(:red)
                    end
                else
                    if [idx1, idx2] != @cursor.cursor_pos
                        row_view << piece.color.to_s
                    else
                        row_view << piece.color.to_s.colorize(:red)
                    end
                end       
            end
            puts row_view.join(" ")
        end
    end

    def display_cursor
        i = 0
        while i < 1
            self.render
            puts "==========================="
            puts "==========================="
            puts "==========================="
            self.cursor.get_input
        end
    end
end



b = Board.new
d = Display.new(b)
d.display_cursor