require_relative '../../lib/handlers/MenuHandler'

class HandleCreateRental < MenuHandler
  def handle_choice(app, _choice)
    app.handle_create_rental
  end
end
