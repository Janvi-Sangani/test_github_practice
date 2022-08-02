module User
  $result = {}
  def user_input
    puts "How many round you want to play?"
    @count_game_round = gets.chomp.to_i
    if @count_game_round <= 0 
      puts "Please enter valid value"
      check_result = Game.new
      check_result.user_input
      check_result.perform 
    end
    puts "How many players you're?"
    $number_of_players = gets.chomp.to_i
    if $number_of_players <= 1
      puts "Please enter valid value"
      check_result = Game.new
      check_result.user_input
      check_result.perform 
    end
  end

  def perform
    count_round = 1
    no_round = 1
    while count_round <= @count_game_round
      puts "\n>>>>>>>>>>>> Round #{no_round} <<<<<<<<<<<<"
      count_player = 1
      no_player = 1
      $result[no_round] = {}
      while count_player <= $number_of_players
        $result[no_round][no_player] = nil
        puts "\nFor Player #{no_player}"
        game_round
        start_game
        answer = check_ans
        $result[no_round][no_player] = answer
        no_player = no_player +1
        count_player = count_player + 1
      end
      no_round = no_round+1
      count_round += 1
    end
    # puts $result
    create_result 
    declare_result
  end
end

module Word
  def game_round
    puts "How many words you want enter"
    @words = gets.chomp.to_i
    @match_array = Array.new(@words)
    for a in 0..(@words-1) do
      puts "Please enter word "
      name_enter = gets.chomp
       @match_array[a] = name_enter
    end
  end
end

class Game
  include User
  include Word
  def start_game
    @result_array = Array.new
    i = 0
    @match_array.each do |ch|
      array_name_enter = ch.split("")
      last_ch = array_name_enter.last
      if i+1 != @words
        second_word = @match_array[i+1]
        array_ch_first = second_word.split("")                                                     
        first_ch = array_ch_first.first
        if last_ch == first_ch
          @result_array << "Yes"
        else
          @result_array << "No"
        end
        i = i+1
      end
    end
  end

  def check_ans
    if @result_array.include?"No"
      puts "Looser"
      looser = "Looser"
    else
      puts "Winner"
      winner = "Winner"
    end
  end

  def create_result
    $final_ans = {}
    $filter_ans = {}
    (1..$number_of_players).each do |i|
      $final_ans[i] = {}
      $filter_ans[i] = {}
      (1..@count_game_round).each do |j|
        ans = $result[j][i]
        $final_ans[i][j] = ans

        $final_ans.each do |k,v|
          main_ans = v.values
          $filter_ans[i] = main_ans
        end
      end
    end
    # puts $filter_ans
  end
  
  def declare_result
    result_hash = {}
    (1..$number_of_players).each do |n|
      winner_count = $filter_ans[n].count("Winner") 
      looser_count = $filter_ans[n].count("Looser")
      final_count_player = { Winner:winner_count, Looser:looser_count}
      result_hash[n] = final_count_player
    end
    puts result_hash
    final_winner = result_hash.max_by{|aa, v| v[:Winner]}
    puts "\nWinner is player no. #{final_winner[0]}"
    puts final_winner[1]
    final_looser = result_hash.max_by{|aa, v| v[:Looser]}
    puts "\nLooser is player no. #{final_looser[0]}"
    puts final_looser[1]
    if final_winner == final_looser
      puts "\nSoory!! Both have a same score you have to play again!!!"
      check_result = Game.new
      check_result.user_input
      check_result.perform 
    end
  end
end

check_result = Game.new
check_result.user_input
check_result.perform 