require_relative '../../lib/handlers/MenuHandler'

class HandleCreatePerson < MenuHandler
  def handle_choice(app, _choice)
    app.handle_create_person
  end
end
