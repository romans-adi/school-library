require_relative '../models/Rental'

class RentalManager
  def initialize
    @rentals = []
  end

  def create_rental(date, book, person)
    return unless date && book && person

    rental = Rental.new(date, book, person)
    @rentals << rental
    rental
  end

  def list_items(items)
    if items.empty?
      puts 'No items available.'
    else
      items.each_with_index do |item, index|
        puts "#{index + 1}. #{item_display_text(item)}"
      end
    end
  end

  def list_all_rentals
    list_items(@rentals)
  end

  def list_rentals_for_person(person_id)
    rentals_for_person = @rentals.select { |rental| rental.person.id == person_id }
    if rentals_for_person.empty?
      puts "No rentals found for the person with ID #{person_id}."
    else
      puts "List of rentals for person with ID #{person_id}:"
      list_items(rentals_for_person)
    end
  end

  private

  def item_display_text(item)
    rental_display_text(item)
  end

  def rental_display_text(rental)
    "Date: #{rental.date}, #{rental.book.title} by #{rental.book.author}"
  end
end
