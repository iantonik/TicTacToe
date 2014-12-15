
WINNING_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]
spaces = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']
positions = ['','','','','','','','','']
available_spaces = [0,1,2,3,4,5,6,7,8]

def initial_board ()
  puts "  a1  |  a2  |  a3 "
  puts "------+------+------"
  puts "  b1  |  b2  |  b3 "
  puts "------+------+-----"
  puts "  c1  |  c2  |  c3 "
end

def get_next_move(sign, positions)
  nextMove = -1
  best_combo = 4
  WINNING_COMBINATIONS.each do |combination|
    unplayed_squares = 3
    blocked = false
    ret_val = -1
    combination.each do |square|
      existing_move = positions[square]
      case existing_move
        when sign
          unplayed_squares = unplayed_squares - 1
        when ''
          ret_val = square
        else
          blocked = true
          break
      end
    end
    next if (blocked)
    if (unplayed_squares == 0)
      #the player has already won
      return 0,nil
    end
    if (unplayed_squares < best_combo)
      best_combo = unplayed_squares
      nextMove = ret_val
    end
  end
  return best_combo,nextMove
end

def board (spaces)
  puts "  #{spaces[0]}  |  #{spaces[1]}  |  #{spaces[2]}"
  puts "----+----+-----"
  puts "  #{spaces[3]}  |  #{spaces[4]}  |  #{spaces[5]}"
  puts "----+----+-----"
  puts "  #{spaces[6]}  |  #{spaces[7]}  |  #{spaces[8]}"
end

puts "Play Tic Tac Toe."
puts "What's your name?"

computer_name = "Joe Computer"
user_name = gets.chomp.capitalize


computer_sign = ['X', 'O'].sample
user_sign = (computer_sign == 'X') ? 'O' : 'X'

puts "Hi #{user_name}, my name is #{computer_name}."
puts "I will use #{computer_sign}, and you will use #{user_sign}. Let's play!"

puts "Here's our board:"
puts initial_board

game_end = false

loop do

good_choice = false

  while !good_choice
    puts "#{user_name} make your move."
    user_choice = gets.chomp.downcase
    choice_index = spaces.index(user_choice)
    if available_spaces.include?(choice_index)
      positions[choice_index] = user_sign
      remaining_moves = get_next_move(user_sign,positions)
      if (remaining_moves == 0)
        puts 'You win!!'
        puts board(positions)
        return
      end
      available_spaces.delete(choice_index)
      good_choice = true
    else
      puts 'That field is already occupied.'
    end
  end

  remaining_moves,next_move = get_next_move(computer_sign, positions) #see if there's a winning move
  if (remaining_moves > 1)
    remaining_moves_user, next_move_block = get_next_move(user_sign, positions) #need to block user?
    if (remaining_moves_user == 1)
      positions[next_move_block] = computer_sign #block user
      available_spaces.delete(next_move_block)
    else
      positions[next_move] = computer_sign
      available_spaces.delete(next_move)
    end
  else
    positions[next_move] = computer_sign
    puts 'Joe wins!'
    game_end = true
  end
  puts board(positions)
  if (available_spaces.count == 0)
    puts 'Stalemate.'
    game_end = true
  end
  break if (game_end)
end







