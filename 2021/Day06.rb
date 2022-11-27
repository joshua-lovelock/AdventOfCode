file = File.read("./resource/day06_input.txt")

initial_state = file.split(',').map(&:to_i)

population = {}
initial_state.each do |num|
  unless population.key?(num)
    population[num] = 1
  else
    population[num] += 1
  end
end

def process_1_day(old_state)
  new_state = {}
  # Baby_fish
  new_state[8] = old_state[0] if old_state[0]
  # Parents
  new_state[6] = old_state[0] if old_state[0]
  # Others
  (1..8).each do |age|
    if old_state.key?(age)
      if new_state.key?(age-1)
        new_state[age - 1] += old_state[age]
      else
        new_state[age - 1] = old_state[age]
      end
    end
  end
  new_state
end

(1..256).each do
  population = process_1_day(population)
end

total = 0
population.each do |k,v|
  total += v
end

puts total