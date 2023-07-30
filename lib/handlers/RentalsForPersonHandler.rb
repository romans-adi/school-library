require_relative '../models/Rental'

class RentalsForPersonHandler
  def initialize(rental_manager)
    @rental_manager = rental_manager
  end

  def list_rentals_for_person
    puts "\nEnter person ID to list all rentals for that person: "
    person_id = gets.chomp.to_i

    @rental_manager.list_rentals_for_person(person_id)
  end
end
