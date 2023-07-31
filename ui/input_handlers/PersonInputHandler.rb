require_relative 'StudentInputHandler'
require_relative 'TeacherInputHandler'

class PersonInputHandler
  def self.prompt_for_data
    puts 'Do you want to create a student or a teacher?'
    print 'Enter (1) for student or (2) for teacher: '
    type = gets.chomp.to_i

    case type
    when 1
      prompt_student_data
    when 2
      prompt_teacher_data
    else
      puts 'Invalid person type. Use (1) for student or (2) for teacher.'
      nil
    end
  end

  def self.prompt_student_data
    print 'Age: '
    age = integer_input

    print 'Name: '
    name = gets.chomp

    print 'Classroom: '
    classroom = gets.chomp
    parent_permission = age < 18 ? ask_parent_permission : true

    { type: :student, age: age, name: name, classroom: classroom, parent_permission: parent_permission }
  end

  def self.prompt_teacher_data
    print 'Age: '
    age = integer_input

    print 'Name: '
    name = gets.chomp

    print 'Specialization: '
    specialization = gets.chomp

    { type: :teacher, age: age, name: name, specialization: specialization }
  end

  def self.integer_input
    input = gets.chomp
    until input.match?(/^\d+$/)
      print 'Please enter a valid age (numeric value): '
      input = gets.chomp
    end
    input.to_i
  end

  def self.ask_parent_permission
    print 'Has parent permission? [Y/n]: '
    permission = gets.chomp.downcase
    permission == 'y'
  end
end
