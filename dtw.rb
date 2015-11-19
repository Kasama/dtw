class DTW
  attr_accessor :a, :b
  def initialize(a, b)
    @a = a
    @b = b
  end

  def dtw_distance
    dtw = Array(@a.length + 1) { Array(@b.length + 1) }

    (1 .. @a.length).each { |t| dtw[t][0] = Float::INFINITY}
    (1 .. @b.length).each { |t| dtw[0][t] = Float::INFINITY}
    dtw[0][0] = 0

    (1 .. @a.length).each do |i|
      (1 ..@b.length).each do |j|
        cost = d(a[i], b[j])
        dtw[i][j] = cost + min(dtw[i-1][j], dtw[i][j-1], dtw[i-1][j-1])
      end
    end
    dtw[@a.length][@b.length]
  end

  def d(a, b)
    (a - b)**2
  end

  def min(a, b, c)
    a if(a < b and a < c)
    b if(b < a and b < c)
    c if(c < b and c < a)
  end
end