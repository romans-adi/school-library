require_relative 'Book'
require_relative 'Person'

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals << self
    person.rentals << self
  end

  def to_hash
    {
      'date' => @date,
      'book' => @book.to_hash, # Include relevant book information using to_hash method
      'person_id' => @person.id
    }
  end
end
