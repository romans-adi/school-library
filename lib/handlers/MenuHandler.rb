class MenuHandler
  def initialize(menu)
    @menu = menu
  end

  def handle_choice(app, choice)
    raise NotImplementedError, 'Subclasses must implement the handle_choice method.'
  end
end
