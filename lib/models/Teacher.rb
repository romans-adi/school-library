require_relative 'Person'

class Teacher < Person
  attr_reader :can_use_services, :specialization

  def initialize(age, name: 'Unknown', can_use_services: true, specialization: 'General')
    super(age, name: name)
    @can_use_services = can_use_services
    @specialization = specialization
  end

  def to_hash
    {
      'type' => 'Teacher',
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'specialization' => @specialization,
      'rentals' => @rentals.map(&:to_hash)
    }
  end

  def can_use_services?
    true
  end
end
