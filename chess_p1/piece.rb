class Piece
    attr_accessor :pos
    attr_reader :color

    def initialize(pos, color)
        @pos = pos
        @color = color
    end
end

class NullPiece < Piece
    def initialize(pos)
        @pos = pos
    end
end