$file_path = "./resource/day03_input.txt"

def parse_input
    file_lines = File.readlines($file_path)
    for index in 0 ... file_lines.size
        file_lines[index] = file_lines[index].chomp("\n")
        file_lines[index] = file_lines[index].split('')
    end
    return file_lines
end

def calc_next_point(current_x, current_y, width, offset_x, offset_y)
    new_y = current_y + offset_y
    new_x = current_x + offset_x
    if new_x >= width
        new_x = new_x % width
    end
    return new_x, new_y
end

def compute_path(terrain_matrix, offset_x, offset_y)
    x_param, y_param = 0, 0
    width = terrain_matrix[0].size
    total_trees = 0
    until y_param >= terrain_matrix.size - 1 do
        x_param, y_param = calc_next_point(x_param, y_param, width, offset_x, offset_y)
        if terrain_matrix[y_param][x_param] == '#'
            total_trees += 1
        end
    end
    return total_trees
end

terrain_matrix = parse_input()
total_trees = compute_path(terrain_matrix, 1, 1) * \
              compute_path(terrain_matrix, 3, 1) * \
              compute_path(terrain_matrix, 5, 1) * \
              compute_path(terrain_matrix, 7, 1) * \
              compute_path(terrain_matrix, 1, 2)

puts total_trees