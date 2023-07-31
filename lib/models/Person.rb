require_relative '../Nameable'
require_relative 'Rental'

class Person < Nameable
  attr_reader :id, :name, :age, :parent_permission
  attr_accessor :rentals

  # rubocop:disable Style/ClassVars
  @@last_assigned_id = 0
  # rubocop:enable Style/ClassVars

  def initialize(age, name: 'Unknown', parent_permission: true)
    super()
    @id = generate_unique_id
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

  def self.init_last_assigned_id(last_assigned_id)
    # rubocop:disable Style/ClassVars
    @@last_assigned_id = last_assigned_id
    # rubocop:enable Style/ClassVars
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_unique_id
    # rubocop:disable Style/ClassVars

    @@last_assigned_id += 1
    # rubocop:enable Style/ClassVars
  end
end
