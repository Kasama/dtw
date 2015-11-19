class DTW
  attr_accessor :a, :b
  def initialize(a, b)
    @a = a
    @b = b
  end

  def dtw_distance(p)

    p = p/100 if p > 1

    w = p*(@b.length)

    w = max(w, abs(@a.length - @b.length))

    dtw = Array.new(@a.length + 1) { Array.new(@b.length + 1, Float::INFINITY) }
    dtw[0][0] = 0

    (1 .. @a.length).each do |i|
      (max(1, i-w) .. min(@b.length, i+w, Float::INFINITY)).each do |j|
        cost = d(a[i-1], b[j-1])
        dtw[i][j] = cost + min(dtw[i-1][j], dtw[i][j-1], dtw[i-1][j-1])
      end
    end
    dtw[@a.length][@b.length]
  end

  def d(a, b)
    (a - b)**2
  end

  def min(a, b, c)
    ret = a
    ret = a if(a < b and a < c)
    ret = b if(b < a and b < c)
    ret = c if(c < b and c < a)
    ret
  end

  def max(a, b)
    return a if a > b
    b
  end

  def abs(a)
    if a > 0
      a
    else
      -a
    end
  end
end