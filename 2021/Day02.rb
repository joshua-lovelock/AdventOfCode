file = File.read("./resource/day02_input.txt").split("\n")
# Part 1
$directionality_map = {"down" => [0, 1],
    "up" =>   [0, -1],
    "forward" => [1, 0]}

def get_change_in_cords (line_tokens)
    change = $directionality_map[line_tokens[0]]
    return [change[0] * line_tokens[1].to_i, change[1] * line_tokens[1].to_i]
end

tokens = file.map {|x| (x.split()) }
             .map { |x| get_change_in_cords(x) } \
             .reduce([0,0]) { |sum, i| [sum[0] + i[0], sum[1] + i[1]]}

total = tokens[0] * tokens[1]
puts "Part 1: x: #{tokens[0]}, y: #{tokens[1]}, total: #{total}"

# Part 2

def update_aim (aim, line)
    if line[0] == "down"
        aim = aim + line[1].to_i
    elsif line[0] == "up" 
        aim = aim - line[1].to_i
    end
    return aim
end

split_lines = file.map {|x| (x.split()) }
aim = 0
x_cord = 0
y_cord = 0

for index in 0 ... split_lines.length
    line = split_lines[index]
    aim = update_aim(aim, line)
    if line[0] == "forward"
        x_cord += line[1].to_i
        y_cord += aim * line[1].to_i
    end
end

total = x_cord * y_cord
puts "Part 2: x: #{x_cord}, y: #{y_cord}, total: #{total}"
