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
end
