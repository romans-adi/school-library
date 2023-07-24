require_relative 'Person'

class Student < Person
  attr_reader :classroom

  def initialize(id, age, classroom:, name: 'Unknown', parent_permission: true)
    super(id, age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def classroom=(classroom)
    @classroom&.students&.delete(self)
    @classroom = classroom
    classroom.students << self if classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
