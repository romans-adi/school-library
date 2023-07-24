# Create Objects on Classes
require_relative 'Person'
require_relative 'TrimmerDecorator'
require_relative 'CapitalizeDecorator'

# Create object person with Decorators
person = Person.new(5, 22, name: 'tyranozaurus')
person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name

