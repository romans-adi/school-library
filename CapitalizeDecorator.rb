require_relative 'Decorator'

# Create CapitalizeDecorator class
class CapitalizeDecorator < Decorator
  def correct_name
    super.capitalize
  end
end
