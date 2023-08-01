class ExitHandler < MenuHandler
  def handle_choice(app, _choice)
    puts 'Exiting...'
    app.save_data
    puts 'Data saved successfully!'
    puts 'Thank you for using this app!'
    exit
  end
end
