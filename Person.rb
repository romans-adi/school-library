require_relative 'Nameable'
require_relative 'Rental'

class Person < Nameable
  attr_reader :id, :name, :age, :parent_permission
  attr_accessor :rentals

  def initialize(id, age, name: 'Unknown', parent_permission: true)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    rentals << rental
    rental.person = self
  end

  private

  def of_age?
    @age >= 18
  end
end
