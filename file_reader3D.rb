class FileReader3D

  attr_reader :test, :base

  def initialize(test, base)
    test_file = File.new(test)
    # test_file_lines = 0
    # test_file.each_line do test_file_lines += 1 end
    # test_file.rewind

    base_file = File.new(base)
    # base_file_lines = 0
    # base_file.each_line do base_file_lines += 1 end
    # base_file.rewind

    # @test = Array.new test_file_lines
    # @base = Array.new base_file_lines
    @test = []
    @base = []

    i = 0
    test_file.each_line do |l|
      cl, values = l.to_s.match(/(\d+) (.*$)/i).captures
      values = values.split ' '
      values = separate_3d values
      @test[i] = {}
      @test[i][:class] = cl
      @test[i][:values] = values
      i += 1
    end

    i = 0
    base_file.each_line do |l|
      cl, values = l.to_s.match(/(\d+) (.*$)/i).captures
      values = values.split(' ')
      values = separate_3d values
      @base[i] = {}
      @base[i][:class] = cl
      @base[i][:values] = values
      i += 1
    end
  end

  def separate_3d(values)
    fin_values = []
    values.each_with_index do |v, j|
      d = (j/3).to_i
      m = (j%3)
      fin_values[d] = [] if m == 0
      fin_values[d][m] = v.to_f
    end
    fin_values
  end
end

# Unit test code
=begin
reader = FileReader.new './teste.txt','./treino.txt'
puts "class = #{reader.test[0][:class]}"
puts "arr = #{reader.test[0][:values]}"
puts "class = #{reader.test[1][:class]}"
puts "arr = #{reader.test[1][:values]}"
puts "class = #{reader.base[0][:class]}"
puts "arr = #{reader.base[0][:values]}"
puts "class = #{reader.base[1][:class]}"
puts "arr = #{reader.base[1][:values]}"
=end
