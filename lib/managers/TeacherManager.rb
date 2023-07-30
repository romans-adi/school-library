require_relative '../models/Person'
require_relative '../models/Teacher'

class TeacherManager
  def initialize
    @teachers = []
    init_last_assigned_id(0)
  end

  def create_teacher(params)
    age = params[:age]
    name = params[:name] || 'Unknown'
    can_use_services = params.key?(:can_use_services) ? params[:can_use_services] : true
    specialization = params[:specialization]

    teacher = Teacher.new(age, name: name, can_use_services: can_use_services, specialization: specialization)
    @teachers << teacher
    teacher
  end

  def list_all_teachers
    list_items(@teachers)
  end

  def find_teacher_by_id(teacher_id)
    @teachers.find { |teacher| teacher.id == teacher_id }
  end

  def init_last_assigned_id(last_assigned_id)
    @last_assigned_id = last_assigned_id
  end

  private

  def list_items(items)
    items.each_with_index do |item, index|
      "#{index + 1}. #{teacher_display_text(item)}"
    end
  end

  def teacher_display_text(teacher)
    formatter = TeacherFormatter.new
    formatter.display_text(teacher)
  end
end
