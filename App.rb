require_relative 'Book'
require_relative 'Person'
require_relative 'Student'
require_relative 'Teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    book
  end

  def create_rental(date, book, person)
    rental = Rental.new(date, book, person)
    @rentals << rental
    rental
  end

  @last_assigned_id = 0

  def create_person(params)
    age = params[:age]
    type = params[:type].to_s.downcase

    name = params[:name] || 'Unknown'

    if %w[student 1].include?(type)
      classroom = params[:classroom]
      parent_permission = params.key?(:parent_permission) ? params[:parent_permission] : age < 18
      person = Student.new(generate_unique_id, age, classroom: classroom, name: name,
                                                    parent_permission: parent_permission)
    elsif %w[teacher 2].include?(type)
      specialization = params[:specialization]
      person = Teacher.new(generate_unique_id, age, specialization, name: name, parent_permission: nil)
    else
      raise ArgumentError, 'Invalid person type. Use :student (or 1) or :teacher (or 2).'
    end

    @people << person
    person
  end

  def list_all_people
    list_items(@people)
  end

  def list_all_books
    list_items(@books)
  end

  def list_rentals_for_person(person_id)
    person = find_person_by_id(person_id)
    if person
      rentals_for_person = person.rentals
      if rentals_for_person.empty?
        puts "No rentals found for the person with ID #{person_id}."
      else
        puts "List of rentals for person with ID #{person_id}:"
        list_items(rentals_for_person)
      end
    else
      puts "Person with ID #{person_id} not found."
    end
  end

  def find_book_by_index(index)
    @books[index - 1] if index.positive? && index <= @books.length
  end

  def ask_parent_permission
    print 'Does the person have parent permission? (Y/n): '
    permission = gets.chomp.downcase
    permission == 'y'
  end

  def find_person_by_id(person_id)
    @people.find { |person| person.id == person_id }
  end

  private

  def list_items(items)
    if items.empty?
      puts 'No items available.'
    else
      items.each_with_index do |item, index|
        puts "#{index + 1}. #{item_display_text(item)}"
      end
    end
  end

  def item_display_text(item)
    case item
    when Book
      book_display_text(item)
    when Student
      student_display_text(item)
    when Teacher
      teacher_display_text(item)
    when Rental
      rental_display_text(item)
    else
      'Unknown item'
    end
  end

  def book_display_text(book)
    "#{book.title} by #{book.author}"
  end

  def student_display_text(student)
    parent_permission = student.parent_permission ? 'Yes' : 'No'
    "#{student.class.name}, Name: #{student.name},  ID: #{student.id}, Age: #{student.age},
    Parent Permission: #{parent_permission}, Classroom: #{student.classroom}"
  end

  def teacher_display_text(teacher)
    can_use_services = teacher.can_use_services? ? 'Yes' : 'No'
    "[#{teacher.class.name}] Name: #{teacher.name}, ID: #{teacher.id}, Age: #{teacher.age},
  Can Use Services: #{can_use_services}, Specialization: #{teacher.specialization}"
  end

  def rental_display_text(rental)
    "Date: #{rental.date}, #{rental.book.title} by #{rental.book.author}"
  end

  def generate_unique_id
    @last_assigned_id ||= 0
    @last_assigned_id += 1
  end
end
