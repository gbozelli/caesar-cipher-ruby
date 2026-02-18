def knight_moves(start_pos, end_pos)
  moves = [
    [2, 1], [2, -1], [-2, 1], [-2, -1],
    [1, 2], [1, -2], [-1, 2], [-1, -2]
  ]

  queue = [[start_pos, [start_pos]]]
  visited = {}
  visited[start_pos] = true

  until queue.empty?
    current_pos, path = queue.shift

    return print_path(path) if current_pos == end_pos

    moves.each do |dx, dy|
      new_x = current_pos[0] + dx
      new_y = current_pos[1] + dy

      next unless new_x.between?(0,7) && new_y.between?(0,7)

      new_pos = [new_x, new_y]

      next if visited[new_pos]

      visited[new_pos] = true
      queue << [new_pos, path + [new_pos]]
    end
  end
end

def print_path(path)
  puts "You made it in #{path.length - 1} moves! Here's your path:"
  path.each { |pos| p pos }
  path
end
