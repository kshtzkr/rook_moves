require_relative "gameboard.rb"
require_relative "rook.rb"

def rook_moves(gameboard, start, finish)
	solution = []
	solution << start

	distance_info = Array.new(8) { Array.new(8) { { distance: nil, parent: nil } } }
	distance_info[finish[0]][finish[1]][:distance] = 0

	end_rook = Rook.new(finish)
	queue = []
	queue << end_rook

	solutionFound = false

	until solutionFound
		position = queue.shift
		distance = 1
		
		position.possible_moves.each do |move|
			if move == start
				solutionFound = true
			end

			if distance_info[move[0]][move[1]][:distance] == nil
				distance_info[move[0]][move[1]][:distance] = distance_info[position.x_position][position.y_position][:distance] + 1
				distance_info[move[0]][move[1]][:parent] = position
				queue << Rook.new(move)
			end
		end
	end

	start_rook = Rook.new(start)

	smallest_distance = 63
	shortest_path = nil
	until shortest_path == finish
		start_rook.possible_moves.each do |move|
			if distance_info[move[0]][move[1]][:distance] != nil && distance_info[move[0]][move[1]][:distance] < smallest_distance
				smallest_distance = distance_info[move[0]][move[1]][:distance]
				shortest_path = move
			end
		end
		solution << shortest_path
		start_rook = Rook.new(shortest_path)
	end

	puts "The shortest path from #{start} to #{finish} is #{solution.inspect}."
	print "\nThe Rook starts at #{start}.\n\n"

	gameboard.add_rook(solution.shift)
	gameboard.display
	solution.each_with_index do |move, index| 
		gameboard.move_rook(move)
		print "\nThen it moves to #{solution[index]}.\n\n"
		gameboard.display
	end
end

gameboard = Gameboard.new
rook_moves(gameboard, [2,4], [2,0])