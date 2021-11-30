file_lines = File.readlines("./resource/day02_input.txt")

def extract_elements_from_line(line)
    min, remainder = line.split('-', 2)
    max, remainder = remainder.split(' ', 2)
    letter = remainder[0]
    password = remainder.reverse.split(" ", 2)[0]
    return min, max, letter, password.reverse
end

def check_password_valid (password)
    min_inst, max_inst, letter, password = extract_elements_from_line(password)
    letter_instances = 0
    password.split('').each { |c|
        if c == letter
            letter_instances += 1
        end
    }
    if letter_instances >= min_inst.to_i && letter_instances <= max_inst.to_i
        return true
    else
        return false
    end
end

def check_password_valid_2 (password)
    index1, index2, letter, password = extract_elements_from_line(password)
    split_pass = password.split('')
    if (split_pass[index1.to_i - 1] == letter) ^ (split_pass[index2.to_i - 1] == letter)
        return true
    else
        return false
    end
end

total_valid_passwords_1 = 0
for index in 0 ... file_lines.size
    if check_password_valid(file_lines[index])
        total_valid_passwords_1 += 1
    end
end

puts "Total Valid Password 1: #{total_valid_passwords_1}"

total_valid_passwords_2 = 0
for index in 0 ... file_lines.size
    if check_password_valid_2(file_lines[index])
        total_valid_passwords_2 += 1
    end
end

puts "Total Valid Password 2: #{total_valid_passwords_2}"