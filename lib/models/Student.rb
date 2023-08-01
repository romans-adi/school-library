require_relative 'Person'

class Student < Person
  attr_reader :classroom

  def initialize(age, name: 'Unknown', parent_permission: true, classroom: 'Unknown')
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def classroom=(classroom)
    @classroom&.students&.delete(self)
    @classroom = classroom
    classroom.students << self if classroom
  end

  def to_hash
    {
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'classroom' => @classroom,
      'rentals' => @rentals.map(&:to_hash) # Include relevant rental information using to_hash method
    }
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
