class ContextSquare
  attr_reader :square, :board, :row, :col

  def initialize(square, board, row, col)
    @square = square
    @board = board
    @row = row
    @col = col
  end

  def row_conflicts
    return 0 if @square.nil?
    my_val = @square.value

    row = @board.row(@row).map(&:value)
    row.delete_at @col
    res = row.count(my_val)
    # res = 0 if res < 0
    res
  end

  def col_conflicts
    return 0 if @square.nil?
    my_val = @square.value

    col = @board.column(@col).map(&:value)
    col.delete_at @row
    res = col.count(my_val)
    # res = 0 if res < 0
    res
  end

  def quad_conflicts
    return 0 if @square.nil?
    my_val = @square.value

    idx = nil
    case quadrant
    when 0
      # 0,0=0 0,1=1 0,2=2
      # 1,0=3 1,1=4 1,2=5
      # 2,0=6 2,1=7 2,2=8
      idx = (@row * 3) + (col - 0)
    when 1
      # 0,3=0 0,4=1 0,5=2
      # 1,3=3 1,4=4 1,5=5
      # 2,3=6 2,4=7 2,5=8
      idx = (@row * 3) + (col - 3)
    when 2
      # 0,6=0 0,7=1 0,8=2
      # 1,6=3 1,7=4 1,8=5
      # 2,6=6 2,7=7 2,8=8
      idx = (@row * 3) + (col - 6)
    when 3
      # 3,0=0 3,1=1 3,2=2
      # 4,0=3 4,1=4 4,2=5
      # 5,0=6 5,1=7 5,2=8
      idx = ((@row - 3) * 3) + (col - 0)
    when 4
      # 3,3=0 3,4=1 3,5=2
      # 4,3=3 4,4=4 4,5=5
      # 5,3=6 5,4=7 5,5=8
      idx = ((@row - 3) * 3) + (col - 3)
    when 5
      # 3,6=0 3,7=1 3,8=2
      # 4,6=3 4,7=4 4,8=5
      # 5,6=6 5,7=7 5,8=8
      idx = ((@row - 3) * 3) + (col - 6)
    when 6
      # 6,0=0 6,1=1 6,2=2
      # 7,0=3 7,1=4 7,2=5
      # 8,0=6 8,1=7 8,2=8
      idx = ((@row - 6) * 3) + (col - 0)
    when 7
      # 6,3=0 6,4=1 6,5=2
      # 7,3=3 7,4=4 7,5=5
      # 8,3=6 8,4=7 8,5=8
      idx = ((@row - 6) * 3) + (col - 3)
    when 8
      # 6,6=0 6,7=1 6,8=2
      # 7,6=3 7,7=4 7,8=5
      # 8,6=6 8,7=7 8,8=8
      idx = ((@row - 6) * 3) + (col - 6)
    end

    quad = @board.quadrant(quadrant).map(&:value)
    quad.delete_at idx
    res = quad.count(my_val)

    res
  end

  def conflicts
    row_conflicts + col_conflicts + quad_conflicts
  end

  # 0 1 2
  # 3 4 5
  # 6 7 8
  def quadrant
    # Magical integer arithmetic
    (@col / 3) + ((@row / 3) * 3)
  end

  def valid?
    conflicts == 0
  end

  def dup
    self.class.new square.dup, @board, @row, @col
  end
end
