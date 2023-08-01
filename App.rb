require_relative 'lib/interfaces/AppInterface'
require_relative 'lib/managers/BookManager'
require_relative 'lib/managers/RentalManager'
require_relative 'lib/managers/StudentManager'
require_relative 'lib/managers/TeacherManager'
require_relative 'lib/handlers/CreateBookHandler'
require_relative 'lib/handlers/CreatePersonHandler'
require_relative 'lib/handlers/CreateRentalHandler'
require_relative 'lib/handlers/MenuHandler'
require_relative 'lib/handlers/ListPeopleHandler'
require_relative 'lib/handlers/RentalsForPersonHandler'
require 'json'

class App < AppInterface
  def initialize
    super
    @book_manager = BookManager.new
    @rental_manager = RentalManager.new
    @student_manager = StudentManager.new
    @teacher_manager = TeacherManager.new
    @create_person_handler = CreatePersonHandler.new(self)
    @create_book_handler = CreateBookHandler.new(self)
    @create_rental_handler = CreateRentalHandler.new(self)
    @list_rentals_for_person_handler = RentalsForPersonHandler.new(@rental_manager)
    @list_people_handler = ListPeopleHandler.new(@student_manager, @teacher_manager)
    @menu_handler = MenuHandler.new(self)
    load_data
  end

  # Book
  def create_book(title, author)
    @book_manager.create_book(title, author)
  end

  def list_all_books
    @book_manager.list_all_books
  end

  def find_book_by_index(index)
    @book_manager.find_book_by_index(index)
  end

  def handle_create_book
    @create_book_handler.handle
  end

  # Rental
  def create_rental(date, book, person)
    @rental_manager.create_rental(date, book, person)
  end

  def list_all_rentals
    @rental_manager.list_all_rentals
  end

  def handle_create_rental
    @create_rental_handler.handle
  end

  def handle_list_rentals_for_person
    @list_rentals_for_person_handler.list_rentals_for_person
  end

  # Person

  def handle_create_person
    @create_person_handler.handle
  end

  def list_all_people
    @list_people_handler.list_all_people
  end

  # Student
  def create_student(params)
    @student_manager.create_student(params)
  end

  def find_student_by_id(student_id)
    @student_manager.find_student_by_id(student_id)
  end

  # Teacher
  def create_teacher(params)
    @teacher_manager.create_teacher(params)
  end

  def find_teacher_by_id(teacher_id)
    @teacher_manager.find_teacher_by_id(teacher_id)
  end

  # Menu

  def handle_menu_choice(choice)
    @menu_handler.handle_choice(choice)
  end

  # Data

  def save_data
    save_books
    save_people
    save_rentals
  end

  def load_data
    load_books
    load_people
    load_rentals
  end

  private

  def save_books
    return unless @book_manager.list_all_books

    File.open('books.json', 'w') do |file|
      json_data = @book_manager.list_all_books.map(&:to_hash)
      file.write(JSON.pretty_generate(json_data))
    end
  end

  def load_books
    return unless File.exist?('books.json')

    begin
      json_data = JSON.parse(File.read('books.json'))
      json_data.each do |data|
        @book_manager.create_book(data['title'], data['author'])
      end
    rescue JSON::ParserError => e
      puts "Error parsing 'books.json': #{e.message}"
    end
  end

  def save_people
    people_data = []

    @student_manager.list_all_students.each do |student|
      people_data << student.to_hash.merge('type' => 'Student')
    end

    @teacher_manager.list_all_teachers.each do |teacher|
      people_data << teacher.to_hash.merge('type' => 'Teacher')
    end

    return if people_data.empty?

    File.write('people.json', JSON.pretty_generate(people_data))
  end

  def load_people
    return unless File.exist?('people.json')

    begin
      json_data = JSON.parse(File.read('people.json'))
      json_data.each do |data|
        if data['type'] == 'Student'
          student_data = {
            age: data['age'],
            name: data['name'],
            classroom: data['classroom'],
            parent_permission: data['parent_permission'] || (data['age'] < 18)
          }
          @student_manager.create_student(student_data)
        elsif data['type'] == 'Teacher'
          @teacher_manager.create_teacher(data)
        end
      end
    rescue JSON::ParserError => e
      puts "Error parsing 'people.json': #{e.message}"
    end
  end

  def save_rentals
    return unless @rental_manager.list_all_rentals

    File.open('rentals.json', 'w') do |file|
      json_data = @rental_manager.list_all_rentals.map(&:to_hash)
      file.write(JSON.pretty_generate(json_data))
    end
  end

  def load_rentals
    return unless File.exist?('rentals.json')

    begin
      json_data = JSON.parse(File.read('rentals.json'))
      json_data.each do |data|
        book = @book_manager.find_book_by_index(data['book_index'])
        person = @student_manager.find_student_by_id(data['person_id']) ||
                 @teacher_manager.find_teacher_by_id(data['person_id'])

        if book && person
          @rental_manager.create_rental(data['date'], book, person)
        else
          puts "Skipping rental creation due to missing book or person: #{data}"
        end
      end
    rescue JSON::ParserError => e
      puts "Error parsing 'rentals.json': #{e.message}"
    end
  end
end
