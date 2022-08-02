module File_working
  def File_working.file_menu
    loop do
    function = ["\n1.Count of character words & line",
      "2.file in reverse",
      "3.frequency of particular word in file",
      "4.Lower case letter in place of upper case letter",]
    puts function
    puts "\nPlease choose any one"
    @user_response = gets.chop.to_i
    File_working.features
    end
  end

  def File_working.features
    case @user_response
    when 1
      operation = File.open("exe2.txt","r+")
      read = File.readlines("exe2.txt").count
      puts "Total lines in file are = #{read}"
      length = File.readlines("exe2.txt")
      text = length.join
      characters = text.length
      puts "Total characters in file are = #{characters}"
      operation.close()

    when 2
      operation = File.open("exe2.txt","r+")
      read = File.read("exe2.txt")
      puts read.reverse
      operation.close()

    when 3
      operation = File.open("exe2.txt","r+")
      read_file = File.read("exe2.txt")
      puts read_file
      split_file = read_file.split
      puts "\nPlease enter word for find frequency!"
      enter_word = (gets.chomp)
      count = 0
      split_file.each do |i|
        if i == enter_word
          count +=1
        end 
      end
      puts "Frequncy of #{enter_word} is #{count}"
      operation.close()

    when 4
      operation = File.open("exe2.txt","r+")
      read = File.read("exe2.txt")
      puts read.swapcase
      operation.close()
    
    when 99
      abort
    else
      puts "Please enter valid number"
    end
  end
end

File_working.file_menu