require './file_reader.rb'
require './dtw.rb'

def get_dtw(test_line, base)
  min = Float::INFINITY
  index = -1

  base.each_with_index do |l, i|
    dtw = DTW.new(test_line[:values], l[:values])
    if (d = dtw.dtw_distance) < min
      min = d
      index = i
    end
  end
  index
end

test_file = './teste.txt'
base_file = './treino.txt'
reader = FileReader.new test_file, base_file
total = 0
hits = 0

reader.test.each_with_index do |l, i|
  index = get_dtw(l, reader.base) #todo get_dtw()
  hits += 1 if l[:class] == reader.base[index][:class]
  total += 1
end

puts("eficiencia = #{hits/total}")
