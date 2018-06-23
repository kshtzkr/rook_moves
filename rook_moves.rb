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
		if start_rook.possible_moves.include?([0,1]) || start_rook.possible_moves.include?([1,1]) || start_rook.possible_moves.include?([2,1]) || start_rook.possible_moves.include?([3,1])

			start_rook.possible_moves.each do |move|
				if move == [4,0] || move == [4,1] ||move == [4,2] || move == [4,3] ||move == [4,4] || move == [4,5] ||move == [4,6]  || move == [4,7]
					shortest_path = move
					solution << shortest_path
					start_rook = Rook.new(shortest_path)
					if finish[1] == 0
						if start[1] != 0
							shortest_path = [4,0] 
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					elsif finish[1] == 1
						if start[1] != 1
							shortest_path = [4,1]
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					elsif finish[1]  == 2
						if start[1] != 2
							shortest_path = [4,2]
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end	
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					elsif finish[1]  == 3
						if start[1] == 3
							shortest_path = [4,3]
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					elsif finish[1]  == 4
						if start[1] != 4
							shortest_path = [4,4]
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					elsif finish[1]  == 5
						if start[1] != 0
							shortest_path = [4,5]
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end	
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					elsif finish[1]  == 6
						if start[1] != 6
							shortest_path = [4,6]
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end	
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					elsif finish[1]  == 7
					  if start[1] != 7
							shortest_path = [4,7]
							solution << shortest_path
							start_rook = Rook.new(shortest_path)
						end	
						shortest_path = finish
						solution << shortest_path
						start_rook = Rook.new(shortest_path)
					end
				end
			end
		else
			start_rook.possible_moves.each do |move|
					
				if distance_info[move[0]][move[1]][:distance] != nil && distance_info[move[0]][move[1]][:distance] < smallest_distance
					smallest_distance = distance_info[move[0]][move[1]][:distance]
					shortest_path = move
				end
			end
			solution << shortest_path
			start_rook = Rook.new(shortest_path)
		end	
	end
	puts "The shortest path from #{start} to #{finish} is #{solution.inspect}."
	print "\nThe rook starts at #{start}.\n\n"

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