class Game2048
  def initialize
    @array = 4.times.map { [ nil ] * 4 }
    2.times { fill }
  end

  def fill
    i, j = rand(4), rand(4)
    return fill if @array[i][j]
    @array[i][j] = [2, 2, 2, 2, 4].shuffle.first
  end

  def move(direction)
    @array = @array.transpose if %w[up down].include?(direction)
    @array.each(&:reverse!) if %w[right down].include?(direction)
    4.times do |i|
      a = @array[i].compact
      4.times { |x| a[x], a[x + 1] = a[x] * 2, nil if a[x].to_i == a[x + 1] }
      @array[i] = a.compact.concat([ nil ] * 4)[0..3]
    end
    @array.each(&:reverse!) if %w[right down].include?(direction)
    @array = @array.transpose if %w[up down].include?(direction)
  end

  def play
    puts @array.map { |line| "[%5s] " * 4 % line }
    move({ a: 'left', s: 'down', d: 'right', w: 'up' }[gets.strip.to_sym])
    fill && play if @array.flatten.include?(nil)
  end
end