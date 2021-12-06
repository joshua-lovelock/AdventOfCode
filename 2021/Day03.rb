file = File.read("./resource/day03_input.txt").split("\n")

line_length = file[0].length

split_by_char = file.map { | x | (x.split(""))}

final_binary = ""

gamma = ""
epsi = ""

for i in 0 ... line_length
    zeros_seen = 0
    for j in 0 ... split_by_char.length
        if split_by_char[j][i] == "0"
            zeros_seen += 1
        end
    end
    if zeros_seen > (split_by_char.length + 0.0) / 2
        gamma = gamma + "0"
        epsi = epsi + "1"
    else
        gamma = gamma + "1"
        epsi = epsi + "0"
    end
end

gamma = gamma.to_i(2)
epsilon = epsi.to_i(2)

puts "Part 1"
puts "Gamma rate: #{gamma}"
puts "Epsilon rate: #{epsilon}"
puts "Total: #{gamma*epsilon}"


# Part 2

file = File.read("./resource/day03_input.txt").split("\n")
file.sort!

def find_item (candidates, count, stat)
    if candidates.length == 1
        return candidates[0]
    end

    # find division point and recurse with split
    counter = 0
    while counter < candidates.length
        if candidates[counter][count] != "0"
            # Found our division point
            break
        end
        counter += 1
    end
    count += 1
    # Call self with half list now we know
    if stat == :oxygen
        if counter > (candidates.length / 2)
            return (find_item(candidates[0..(counter-1)], count, stat))
        elsif counter == (candidates.length / 2) && candidates[counter][count] == "1"
            return (find_item(candidates[0..(counter-1)], count, stat))
        else
            return (find_item(candidates[counter..], count, stat))
        end
    else
        if counter <= (candidates.length / 2)
            return (find_item(candidates[0..(counter-1)], count, stat))
        elsif counter == (candidates.length / 2) && candidates[counter][count] == "0"
            return (find_item(candidates[0..(counter-1)], count, stat))
        else
            return (find_item(candidates[counter..], count, stat))
        end
    end
end

result1 = find_item(file, 0, :oxygen).to_i(2)
result2 = find_item(file, 0, :co2).to_i(2)

puts "Part 2"
puts "Oxygen #{result1}"
puts "CO2 #{result2}"
puts "Total #{result2 * result1}"