class ExitHandler < MenuHandler
  def handle_choice(_app, _choice)
    puts 'Thank you for using this app!'
    exit
  end
end
