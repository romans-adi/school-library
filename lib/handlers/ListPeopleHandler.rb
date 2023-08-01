require_relative '../managers/StudentManager'
require_relative '../managers/TeacherManager'
require_relative '../formatters/StudentFormatter'
require_relative '../formatters/TeacherFormatter'

class ListPeopleHandler
  def initialize(student_manager, teacher_manager)
    @student_manager = student_manager
    @teacher_manager = teacher_manager
  end

  def list_all_people
    all_students = @student_manager.list_all_students
    all_teachers = @teacher_manager.list_all_teachers

    return puts 'No people available.' if all_students.empty? && all_teachers.empty?

    total_people = 0
    student_count = display_people(all_students, total_people)
    teacher_count = display_people(all_teachers, student_count)

    total_people += student_count + teacher_count

    puts "Total People: #{total_people}, Total Students: #{student_count}, Total Teachers: #{teacher_count}"
  end

  private

  def display_people(people, total_people)
    return 0 if people.empty?

    count = total_people
    people.each do |person|
      count += 1
      formatter = person_formatter_for(person)
      if formatter
        puts "#{count}. #{formatter.display_text(person)}"
      else
        puts "#{count}. Unrecognized person type."
      end
    end

    count - total_people
  end

  def person_formatter_for(person)
    if person.is_a?(Student)
      StudentFormatter.new
    elsif person.is_a?(Teacher)
      TeacherFormatter.new
    else
      raise ArgumentError, 'Unsupported person type.'
    end
  end
end
