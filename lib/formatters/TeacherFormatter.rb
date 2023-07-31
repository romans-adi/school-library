require_relative '../interfaces/PersonFormatter'

class TeacherFormatter
  include PersonFormatter

  def display_text(teacher)
    can_use_services = teacher.can_use_services? ? 'Yes' : 'No'
    "[Teacher] Name: #{teacher.name}, ID: #{teacher.id}, Age: #{teacher.age},
    Can Use Services: #{can_use_services}, Specialization: #{teacher.specialization}"
  end
end
