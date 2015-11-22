require './file_reader3D.rb'
require './dtw.rb'
require './dtw3d.rb'

def get_dtw(test_line, base, p = 1)
  min = Float::INFINITY
  index = -1

  base.each_with_index do |l, i|
    dtw = DTW3D.new(test_line[:values], l[:values])
    if (d = dtw.dtw_distance(p)) < min # p is the percentage
      min = d
      index = i
    end
  end
  index
end

test_file = './teste3D.txt'
base_file = './treino3D.txt'
reader = FileReader3D.new test_file, base_file

percentages = [0, 0.05, 0.1, 0.2, 0.5, 1]

percentages.each do |p|
  total = 0
  hits = 0

  puts "Running for #{p*100}%"
  puts '################################################################################################'
  time = Time.now
  reader.test.each_with_index do |l, i|
    putc '#' if i % 10 == 0
    index = get_dtw(l, reader.base, p)
    hits += 1 if l[:class] == reader.base[index][:class]
    total += 1
  end
  time = Time.now - time
  puts "\nPercentage: #{p*100}%"
  puts "hits: #{hits}\ntotal: #{total}"
  puts "efficiency = #{hits.to_f/total}"
  puts "time = #{time}ms"
end
