require_relative '../../ui/input_handlers/RentalInputHandler'

class CreateRentalHandler
  def initialize(app)
    @app = app
  end

  def handle
    rental_data = RentalInputHandler.prompt_for_data(@app)
    return if rental_data.nil?

    @app.create_rental(rental_data[:date], rental_data[:book], rental_data[:person])

    puts "\nRental created successfully:"
    puts "Book: #{rental_data[:book].title} by #{rental_data[:book].author}"
    puts "Person: #{rental_data[:person].name}"
    puts "Rental Date: #{rental_data[:date]}"
  end
end
