class Menu
  def display
    puts "\nWelcome To School Library App!"
    puts 'Please, choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person ID'
    puts '7 - Exit'
  end

  def prompt_choice
    print "\nChoose an option (1-7): "
    gets.chomp.to_i
  end
end
