class DTW3D < DTW

  def distance(a, b)
    d = ((a[0]+b[0])**2) + ((a[1]+b[1])**2)
    d = d + ((a[2]+b[2])**2)
    Math.sqrt(d)
  end
end