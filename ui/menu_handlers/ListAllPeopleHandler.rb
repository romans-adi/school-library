require_relative '../../lib/handlers/MenuHandler'

class ListAllPeopleHandler < MenuHandler
  def handle_choice(app, _choice)
    app.list_all_people
  end
end
