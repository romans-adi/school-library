require_relative 'App'

def display_menu
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

def person_params(_app)
  params = {}

  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  person_type_input = gets.chomp.downcase

  print 'Age: '
  params[:age] = gets.chomp.to_i

  print 'Name: '
  params[:name] = gets.chomp

  case person_type_input
  when '1', 'student'
    params[:type] = :student
    params[:parent_permission] = params[:age] < 18 ? ask_parent_permission : true
    fetch_classroom(params)
  when '2', 'teacher'
    params[:type] = :teacher
    fetch_specialization(params)
  else
    puts 'Invalid person type. Use "1" for student or "2" for teacher.'
    return nil
  end

  params
end

def ask_parent_permission
  print 'Has parent permission? [Y/n]: '
  permission = gets.chomp.downcase
  permission == 'y'
end

def fetch_specialization(params)
  print 'Specialization: '
  params[:specialization] = gets.chomp
end

def fetch_classroom(params)
  if params[:type] == :student
    print 'Classroom: '
    params[:classroom] = gets.chomp
  end
  params
end

def book_params
  params = {}
  print 'Title: '
  params[:title] = gets.chomp

  print 'Author: '
  params[:author] = gets.chomp

  params
end

def rental_params(app)
  params = {}
  print 'Enter rental date (YYYY-MM-DD): '
  params[:date] = gets.chomp

  puts "\nAvailable people:"
  app.list_all_people

  print "\nEnter person ID for the rental: "
  params[:person_id] = gets.chomp.to_i

  puts "\nAvailable books:"
  app.list_all_books

  print "\nEnter book index for the rental: "
  params[:book_index] = gets.chomp.to_i

  params
end

def handle_create_person(app)
  params = person_params(app)
  if params
    person = app.create_person(params)
    if person
      puts "Person with ID #{person.id} created successfully."
    else
      puts 'Failed to create a person.'
    end
  else
    puts 'Invalid person params. Failed to create a person.'
  end
end

def handle_create_rental(app)
  book = prompt_user_to_select_book(app)
  return puts 'Invalid book index. Rental creation failed.' if book.nil?

  person = prompt_user_to_select_person(app)
  return puts "Person with ID #{person.id} not found. Rental creation failed." if person.nil?

  date = prompt_user_for_rental_date

  app.create_rental(date, person, book)

  puts "\nRental created successfully:"
  puts "Book: #{book.title} by #{book.author}"
  puts "Person: #{person.name}"
  puts "Rental Date: #{date}"
end

def prompt_user_to_select_book(app)
  puts "\nAvailable books:"
  app.list_all_books

  print "\nSelect a book from the following list by number: "
  book_index = gets.chomp.to_i

  app.find_book_by_index(book_index)
end

def prompt_user_to_select_person(app)
  puts "\nAvailable people:"
  app.list_all_people

  print "\nEnter person ID for the rental: "
  person_id = gets.chomp.to_i

  app.find_person_by_id(person_id)
end

def prompt_user_for_rental_date
  print "\nEnter rental date (DD-MM-YYYY): "
  gets.chomp
end

def handle_create_book(app)
  params = book_params
  book = app.create_book(params[:title], params[:author])
  return unless book

  puts "Book #{book.title} created successfully"
end

def handle_list_rentals_for_person(app)
  print "\nEnter person ID to list rentals: "
  person_id = gets.chomp.to_i

  app.list_rentals_for_person(person_id)
end

def handle_menu_choice(choice, app)
  case choice
  when 1 then app.list_all_books
  when 2 then app.list_all_people
  when 3 then handle_create_person(app)
  when 4 then handle_create_book(app)
  when 5 then handle_create_rental(app)
  when 6 then handle_list_rentals_for_person(app)
  else
    puts 'Thank you for using this app!'
    exit
  end
end

def main
  app = App.new

  loop do
    display_menu
    print "\nChoose an option (1-7): "
    choice = gets.chomp.to_i
    handle_menu_choice(choice, app)
  end
end

main
