file_lines = File.read("./resource/day04_input.txt").split("\n")

number_stream = file_lines.shift.split(',').map(&:to_i)

collections = []

current_board = []
while (file_lines.length > 0) do
    current_line = file_lines.shift
    if current_line == ""
        collections.append(current_board) if !current_board.empty?
        current_board = []
    else
        current_board << current_line.split(' ').map(&:to_i)
    end
end

# Bingo sheet:
# 5 lines of 5 chars each
# iterates
def check_against_rows(bingo_sheet, numbers)
    matches = bingo_sheet.find do |row|
        row.all? {|s| numbers.include?(s)}
    end
    return !matches.nil?
end

def check_against_columns(bingo_sheet, numbers)
    check_against_rows(bingo_sheet.transpose.map(&:reverse), numbers)
end


def check_bingo_numbers(bingo_sheet, numbers)
    check_against_rows(bingo_sheet, numbers) || check_against_columns(bingo_sheet, numbers)
end

bingo_numbers = 1
while true do
    matching = collections.find do |sheet|
        sheet if check_bingo_numbers(sheet, number_stream.take(bingo_numbers))
    end

    break unless matching.nil?

    bingo_numbers = bingo_numbers + 1
end

# puts matching
puts "bingo numbers"
puts number_stream.take(bingo_numbers)

def gen_score_from_matching(sheet, numbers)
    totals = {}
    # Sum all
    sheet.map do |row|
        row.map do |item|
            totals[item] = 0 unless totals.key?(item)
            totals[item] += item.to_i
        end
    end
    # Strip out all that were matched
    (numbers & totals.keys).each do |number|
        totals[number] = 0
    end
    # Sum
    total_count = 0
    totals.each do |k, v|
        total_count+= v
    end
    return total_count * numbers.last
end

puts gen_score_from_matching(matching, number_stream.take(bingo_numbers))


# Part 2

bingo_numbers = 1
candidates = collections
while true do
    candidates = candidates.reject do |sheet|
        check_bingo_numbers(sheet, number_stream.take(bingo_numbers))
    end

    break if candidates.count == 1

    bingo_numbers = bingo_numbers + 1
end

while true do
    break if check_bingo_numbers(candidates.first, number_stream.take(bingo_numbers))
    bingo_numbers = bingo_numbers + 1
end

puts candidates.count
puts gen_score_from_matching(candidates.first, number_stream.take(bingo_numbers))
