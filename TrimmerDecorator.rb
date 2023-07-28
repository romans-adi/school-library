require_relative 'Trimmable'
require_relative 'Decorator'

class TrimmerDecorator < Decorator
  include Trimmable

  def correct_name
    trim_name(super)
  end
end
