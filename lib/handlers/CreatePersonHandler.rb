require_relative '../../ui/input_handlers/PersonInputHandler'

class CreatePersonHandler
  def initialize(app)
    @app = app
  end

  def handle
    person_data = PersonInputHandler.prompt_for_data
    if person_data
      if person_data[:type] == :student
        student = @app.create_student(person_data)
        if student
          puts "Student with ID #{student.id} created successfully."
        else
          puts 'Failed to create a student.'
        end
      elsif person_data[:type] == :teacher
        teacher = @app.create_teacher(person_data)
        if teacher
          puts "Teacher with ID #{teacher.id} created successfully."
        else
          puts 'Failed to create a teacher.'
        end
      else
        puts 'Invalid person type. Use (1) for student or (2) for teacher.'
      end
    else
      puts 'Invalid person params. Failed to create a person.'
    end
  end
end
