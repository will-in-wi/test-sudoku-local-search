class Square
  VALID_VALS = 1..9

  attr_reader :value, :original

  def initialize(val)
    self.value = val unless val.nil?

    @original = !val.nil?
  end

  def value=(val)
    raise ArgumentError, 'Argument out of bounds' unless VALID_VALS.include?(val)
    raise ArgumentError, 'Cannot change original square' if @original

    @value = val
  end

  def original?
    @original
  end

  def nil?
    @value.nil?
  end

  def not_nil?
    !nil?
  end
end
