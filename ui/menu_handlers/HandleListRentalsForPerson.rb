require_relative '../../lib/handlers/MenuHandler'

class HandleListRentalsForPerson < MenuHandler
  def handle_choice(app, _choice)
    app.handle_list_rentals_for_person
  end
end
