require_relative 'Decorator'

# Create TrimmerDecorator class
class TrimmerDecorator < Decorator
  def correct_name
    super[0..9]
  end
end
