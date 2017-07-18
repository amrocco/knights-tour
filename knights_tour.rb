class KnightsTour
	def initialize
		board = [nil, nil, nil, nil, nil, nil, nil, nil]
		8.times do |i|
			board[i] = [0, 0, 0, 0, 0, 0, 0, 0]
		end
		tour(0,0,board)
	end

	def tour(x,y,board,current_move=0)
		current_move +=1
		board[x][y] = current_move

		puts board if current_move == 64
		exit if current_move == 64

		ordered_neighbors = 
			neighbors(x,y,board).sort_by { |m| m[:weight] }

		ordered_neighbors.each do |move|
			tour(move[:x], move[:y], board, current_move)
		end

		board[x][y] = 0
		false
	end

	def weight(x,y,board)
		possible = 0
		moves(x,y).each do |move|
			next unless valid_move?(move, board)
			possible +=1
		end
		possible
	end

	def neighbors(x,y,board)
		neighbors = []
		moves(x,y).each do |move|
			next unless valid_move?(move, board)
			neighbors << { weight: weight(move[:x], move[:y], board), 
				                x: move[:x], y: move[:y] }
		end
		neighbors
	end

	def valid_move?(move,board)
		x = move[:x]
		y = move[:y]
		!(board[x] == nil || board[x][y] == nil || 
		  board[x][y] != 0 || x < 0 || y < 0)
	end

	def moves(x,y)
		[{x: x+2, y: y+1},
		 {x: x+2, y: y-1}, 
		 {x: x+1, y: y-2}, 
		 {x: x-1, y: y-2}, 
		 {x: x-1, y: y+2}, 
		 {x: x+1, y: y+2}, 
		 {x: x-2, y: y+1}, 
		 {x: x-2, y: y-1}]
	end
end

KnightsTour.new
