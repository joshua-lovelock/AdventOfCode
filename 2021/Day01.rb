file = File.read("./resource/day01_input.txt").split
$readings_list = file.map(&:to_i)

def task1    
    last_reading = nil
    increases = 0
    for index in 0 ... $readings_list.size
        if last_reading != nil && $readings_list[index] > last_reading
            increases += 1
        end
        last_reading = $readings_list[index]
    end
    return increases
end

def task2
    last_reading = nil
    increases = 0
    for index in 0 ... $readings_list.size - 2
        window_total = $readings_list[index] + $readings_list[index + 1] + $readings_list[index + 2]
        if last_reading != nil && window_total > last_reading
            increases += 1
        end
        last_reading = window_total
    end
    return increases
end


puts "Answer 1: " + task1.to_s
puts "Answer 2: " + task2.to_s
