require_relative '../../lib/handlers/MenuHandler'

class ListAllBooksHandler < MenuHandler
  def handle_choice(app, _choice)
    app.list_all_books
  end
end
