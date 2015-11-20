class DTW
  attr_accessor :test, :base
  def initialize(a, b)
    @test = a
    @base = b
  end

  def dtw_distance(p)

    p = p/100 if p > 1

    w = p*(@base.length)

    w = max(w, abs(@test.length - @base.length))
    w = w.to_i

    dtw = Array.new(@test.length + 1) { Array.new(@base.length + 1, Float::INFINITY) }
    dtw[0][0] = 0

    (1 .. @test.length).each do |i|
      (max(1, i-w) .. min2(@base.length, i+w)).each do |j|
        cost = distance(a[i-1], b[j-1])
        dtw[i][j] = cost + min(dtw[i-1][j], dtw[i][j-1], dtw[i-1][j-1])
      end
    end
    dtw[@test.length][@base.length]
  end

  def distance(a, b)
    (a - b)**2
  end

  def min(a, b, c)
    ret = a
    ret = a if(a < b and a < c)
    ret = b if(b < a and b < c)
    ret = c if(c < b and c < a)
    ret
  end

  def min2(a, b)
    return a if a < b
    b
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