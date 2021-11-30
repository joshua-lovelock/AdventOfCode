file = File.read("./resource/day01_input.txt").split
file = file.map(&:to_i)

def simple_find(file)    
    for index1 in 0 ... file.size
        for index2 in 0 ... file.size
            if index1 == index2
                next
            end
            for index3 in 0 ... file.size
                if index3 == index1 || index3 == index2
                    next
                end
                if file[index1] + file[index2] + file[index3] == 2020
                    return file[index1] * file[index2] * file[index3]
                end
            end
        end
    end
end

puts simple_find(file)