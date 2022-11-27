file_lines = File.read("./resource/day05_input.txt").split("\n")

all_vectors = file_lines.map do |line|
  v = line.split(" -> ")
  v.map do |i|
    i.split(',').map(&:to_i)
  end
end

# Filter 
straight_vectors = all_vectors.reject do |vector|
  point1 = vector.first
  point2 = vector.last
  (point1.first != point2.first) && (point1.last != point2.last) 
end

# Expand out to all points

all_points = {}

def return_range(val1, val2)
  if val1 < val2
    return (val1..val2)
  end
  return (val2..val1)
end

def add_to_all_points(key, all_points)
  all_points[key] = 0 unless all_points.key?(key)
  all_points[key] += 1
end

def process(straight_vectors)
  all_points = {}  
  straight_vectors.each do |vector|
    point1 = vector.first
    point2 = vector.last
    
    # For each change in y create new
    if (point1.first == point2.first)
      (return_range(point1.last,point2.last)).each do |y_value|
        add_to_all_points([point1.first, y_value], all_points)
      end
    elsif (point1.last == point2.last)
      (return_range(point1.first,point2.first)).each do |x_value|
        add_to_all_points([x_value, point1.last], all_points)
      end
    else
      # We have a 45 deg
      x_direction = point1.first > point2.first
      y_direction = point1.last > point2.last

      counter = 0
      while true do
        new_x = (x_direction ? point1.first - counter : point1.first + counter)
        new_y = (y_direction ? point1.last - counter : point1.last + counter)
        new_point = [new_x, new_y]
        add_to_all_points(new_point ,all_points)
        break if new_point.first == point2.first
        counter += 1
      end
    end
  end
  return all_points
end

# Part 1
total_overlaps_pt1 = process(straight_vectors).select do |point, overlaps|
  overlaps > 1
end

puts total_overlaps_pt1.keys.count

# Part 2
total_overlaps_pt2 = process(all_vectors).select do |point, overlaps|
  overlaps > 1
end

puts total_overlaps_pt2.keys.count

