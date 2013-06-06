class Editor
  attr_accessor :x, :y, :image

  def parse
    prompt
    case gets.chomp
    when /^I (.*)/
      setup($1)
    when /^C/
      if self.x && self.y
        clear
      else
        puts "Please initialize using I X Y first."
      end
    when /^L (.*)/
      single_pixel($1)
    when /^V (.*)/
      vertical_line($1)
    when /^H (.*)/
      horizontal_line($1)
    when /^F (.*)/
      fill($1)
    when /^S/
      show
    when /^X/
      quit
    end
  end

  def single_pixel(string)
    x_value, y_value, colour = string.split(' ')

    x_value, y_value = x_value.to_i, y_value.to_i
    lines = image.split("\n")
    lines[y_value - 1][x_value - 1] = colour
    self.image = lines.join("\n")
  end

  def vertical_line(string)
    x_value, y_value1, y_value2, colour = string.split(' ')
    x_value, y_value1, y_value2 = x_value.to_i, y_value1.to_i, y_value2.to_i
    lines = image.split("\n")
    (y_value1..y_value2).each do |y_value|
      lines[y_value - 1][x_value - 1] = colour
    end
    self.image = lines.join("\n")
  end

  def horizontal_line(string)
    y_value, x_value1, x_value2, colour = string.split(' ')
    y_value, x_value1, x_value2 = y_value.to_i, x_value1.to_i, x_value2.to_i
    lines = image.split("\n")
    lines[y_value][(x_value1 - 1)..(x_value2 - 1)] = colour * ((x_value2 - x_value1) + 1)
    self.image = lines.join("\n")
  end

  def setup(string)
    self.x, self.y = string.split(' ').map(&:to_i)

    self.image = ""
    x.times { self.image << (('O' * y) + "\n") }
  end

  def clear
    self.image = ""
    x.times { self.image << (('O' * y) + "\n") }
  end

  def show
    puts self.image
  end

  def prompt
    print "> "
  end
end

while true
  editor ||= Editor.new
  editor.parse
end


