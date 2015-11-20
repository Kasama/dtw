require './file_reader.rb'
require './dtw.rb'

def get_dtw(test_line, base, p = 1)
  min = Float::INFINITY
  index = -1

  base.each_with_index do |l, i|
    dtw = DTW.new(test_line[:values], l[:values])
    if (d = dtw.dtw_distance(p)) < min # p is the percentage
      min = d
      index = i
    end
  end
  index
end

test_file = './teste.txt'
base_file = './treino.txt'
reader = FileReader.new test_file, base_file

percentages = [0, 0.05, 0.1, 0.2, 0.5, 1]

percentages.each do |p|
  total = 0
  hits = 0

  puts "Running for #{p*100}%"
  puts '#########################################################################################################'
  reader.test.each_with_index do |l, i|
    putc '#' if i % 10 == 0
    index = get_dtw(l, reader.base, p)
    hits += 1 if l[:class] == reader.base[index][:class]
    total += 1
  end
  puts "\nPercetage: #{p*100}%"
  puts "hits: #{hits}\ntotal: #{total}"
  puts "eficiencia = #{hits.to_f/total}"
end
