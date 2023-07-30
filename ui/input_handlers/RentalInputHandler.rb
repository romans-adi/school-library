class RentalInputHandler
  def self.prompt_for_data(app)
    book = prompt_user_to_select_book(app)
    return nil if book.nil?

    person = prompt_user_to_select_person(app)
    return nil if person.nil?

    date = prompt_user_for_rental_date

    { book: book, person: person, date: date }
  end

  def self.prompt_user_to_select_book(app)
    puts "\nAvailable books:"
    app.list_all_books

    print "\nSelect a book from the following list by number: "
    book_index = gets.chomp.to_i

    app.find_book_by_index(book_index)
  end

  def self.prompt_user_to_select_person(app)
    puts "\nAvailable people:"
    app.list_all_people

    print "\nEnter person ID for the rental: "
    person_id = gets.chomp.to_i

    person = app.find_teacher_by_id(person_id)
    person ||= app.find_student_by_id(person_id)

    puts 'Person with the given ID was not found.' if person.nil?

    person
  end

  def self.prompt_user_for_rental_date
    print "\nEnter rental date (DD-MM-YYYY): "
    gets.chomp
  end
end
