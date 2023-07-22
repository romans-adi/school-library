# Create Objects on Classes
require_relative 'Person'
require_relative 'Student'
require_relative 'Teacher'

# Create objects
person1 = Person.new(1, 25)
student1 = Student.new(2, 16, 'Math Class', 'Alice')
student2 = Student.new(4, 16, 'Math Class', 'Alice', false)
Teacher.new(3, 35, 'Science', 'Mr. Smith')

puts "Can person with ID #{person1.id} and name #{person1.name} use service?"

if person1.can_use_services?
  puts "Yes, the person could use the service, because their age is #{person1.age}."
elsif person1.instance_variable_get(:@parent_permission)
  puts "Yes, the person with ID #{person1.id} could use the service despite age restriction,
  because of having parents' permission."
else
  puts "No, the person with ID #{person1.id} is too young and has no parents' permission."
end

puts "Can person with ID #{student1.id} and name #{student1.name} use service?"

if student1.can_use_services?
  if student1.instance_variable_get(:@parent_permission)
    puts "Yes, the person with ID #{student1.id} could use the service despite age restriction,
    because of having parents' permission."
  else
    puts "No, the person with ID #{student1.id} is too young and has no parents' permission."
  end
else
  puts "No, the person with ID #{student1.id} is too young and has no parents' permission."
end

puts "Can person with ID #{student2.id} and name #{student2.name} use service?"

if student2.can_use_services?
  if student2.instance_variable_get(:@parent_permission)
    puts "Yes, the person with ID #{student2.id} could use the service despite age restriction,
    because of having parents' permission."
  else
    puts "No, the person with ID #{student2.id} is too young and has no parents' permission."
  end
else
  puts "No, the person with ID #{student2.id} is too young and has no parents' permission."
end
