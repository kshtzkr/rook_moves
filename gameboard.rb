require_relative "rook.rb"

class Gameboard
	attr_accessor :pieces, :positions, :rook

	def initialize
		@pieces = {
			black_king: "♔",
			black_queen: "♕",
			black_rook: "♖",
			black_bishop: "♗",
			black_knight: "♘",
			black_pawn: "♙",
			white_king: "♚",
			white_queen: "♛",
			white_rook: "♜",
			white_bishop: "♝",
			white_knight: "♞",
			white_pawn: "♟" 
		}
		@positions = Array.new(8) { Array.new(8, " ") }
	end

	def display
		rows
		@positions.each_index do |row|
			print "#{row}  "
			@positions[row].each_index do |column|
				print "| #{@positions[row][column]}  "
			end
			puts "|"
			rows
		end
		x_axis
	end

	def rows
		print "   "
		8.times.each { print "+----" }
		puts "+"
	end

	def x_axis
		print "   "
		(0..7).each { |letter| print "  #{letter}  "}
		puts ""
	end

	def add_rook(position)
		@rook = Rook.new(position)
		@positions[@rook.x_position][@rook.y_position] = @pieces[:white_rook]
	end

	def move_rook(position)
		@positions[@rook.x_position][@rook.y_position] = " "
		@rook.x_position = position[0]
		@rook.y_position = position[1]
		@positions[@rook.x_position][@rook.y_position] = @pieces[:white_rook]
	end
end