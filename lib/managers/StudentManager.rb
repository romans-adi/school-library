require_relative '../models/Person'
require_relative '../models/Student'

class StudentManager
  def initialize
    @students = []
    init_last_assigned_id(0)
  end

  def create_student(params)
    age = params[:age]
    name = params[:name] || 'Unknown'
    classroom = params[:classroom]
    parent_permission = params.key?(:parent_permission) ? params[:parent_permission] : age < 18

    student = Student.new(age, name: name, parent_permission: parent_permission, classroom: classroom)
    @students << student
    student
  end

  def list_all_students
    list_items(@students)
  end

  def find_student_by_id(student_id)
    @students.find { |student| student.id == student_id }
  end

  def init_last_assigned_id(last_assigned_id)
    @last_assigned_id = last_assigned_id
  end

  private

  def list_items(items)
    items.each_with_index do |item, index|
      "#{index + 1}. #{student_display_text(item)}"
    end
  end

  def student_display_text(student)
    formatter = StudentFormatter.new
    formatter.display_text(student)
  end
end
