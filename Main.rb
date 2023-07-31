require_relative 'App'
require_relative 'ui/Menu'
require_relative 'ui/menu_handlers/ListAllBooksHandler'
require_relative 'ui/menu_handlers/ListAllPeopleHandler'
require_relative 'ui/menu_handlers/HandleCreatePerson'
require_relative 'ui/menu_handlers/HandleCreateBook'
require_relative 'ui/menu_handlers/HandleCreateRental'
require_relative 'ui/menu_handlers/HandleListRentalsForPerson'
require_relative 'ui/menu_handlers/ExitHandler'

class Main
  def initialize(app)
    @app = app
    @menu = Menu.new
    @menu_handlers = {
      1 => ListAllBooksHandler.new(@app),
      2 => ListAllPeopleHandler.new(@app),
      3 => HandleCreatePerson.new(@app),
      4 => HandleCreateBook.new(@app),
      5 => HandleCreateRental.new(@app),
      6 => HandleListRentalsForPerson.new(@app),
      7 => ExitHandler.new(@app)
    }
  end

  def main
    loop do
      @menu.display
      choice = @menu.prompt_choice
      @menu_handlers[choice]&.handle_choice(@app, choice)
    end
  end
end

app = App.new
main = Main.new(app)
main.main
