require_relative '../../lib/handlers/MenuHandler'

class HandleCreateBook < MenuHandler
  def handle_choice(app, _choice)
    app.handle_create_book
  end
end
