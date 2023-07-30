require_relative '../interfaces/PersonFormatter'

class StudentFormatter
  include PersonFormatter

  def display_text(student)
    parent_permission = student.parent_permission ? 'Yes' : 'No'
    "[Student] Name: #{student.name}, ID: #{student.id}, Age: #{student.age},
    Parent Permission: #{parent_permission}, Classroom: #{student.classroom}"
  end
end
