require_relative 'Main'
require_relative 'App'

app = App.new
main = Main.new(app)
main.main
