# Create Objects on Classes
require_relative 'Person'
require_relative 'Student'
require_relative 'Teacher'

# Create objects
person1 = Person.new(1, 25)
student1 = Student.new(4, 16, classroom: 'Math Class', name: 'Alice', parent_permission: true)
teacher1 = Teacher.new(3, 35, 'Science', name: 'Mr. Smith')

puts "\nCan person with ID #{person1.id} use service?"
if person1.can_use_services?
  puts "Yes, the person could use the service, because their age is #{person1.age}."
elsif person1.instance_variable_get(:@parent_permission)
  puts "Yes, the person with ID #{person1.id} could use the service despite age restriction,
  because of having parents' permission."
else
  puts "No, the person with ID #{person1.id} is too young and has no parents' permission."
end

puts "\nWhich classroom student with ID #{student1.id} is from?"
puts "Student with ID #{student1.id} is from #{student1.classroom}"

puts "\nCan #{student1.name} use service?"
if student1.can_use_services?
  if student1.instance_variable_get(:@parent_permission)
    puts "Yes, #{student1.name} could use the service despite age restriction,
    because of having parents' permission."
  else
    puts "No, #{student1.name} is too young and has no parents' permission."
  end
else
  puts "No, #{student1.name} is too young and has no parents' permission."
end

puts "\nID: #{teacher1.id}"
puts "Name: #{teacher1.name}"
puts "Age: #{teacher1.age}"
puts "Specialization: #{teacher1.specialization}"
puts "Can use services?: #{teacher1.can_use_services?}"
