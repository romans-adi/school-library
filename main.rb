require_relative 'Classroom'
require_relative 'Student'
require_relative 'Book'
require_relative 'Person'
require_relative 'Rental'

classroom = Classroom.new('Math')
student1 = Student.new(1, 16, classroom: classroom, name: 'Alice')
Student.new(2, 17, classroom: classroom, name: 'Bob')
student3 = Student.new(3, 30, classroom: classroom, name: 'Romans')

# Test Classroom's label getter and setter
puts "Classroom label: #{classroom.label}"
classroom.label = 'Math'
puts "Updated classroom label: #{classroom.label}"

# Test has-many relationship (Classroom - Students)
puts 'Students in the classroom:'
classroom.students.each do |student|
  puts "#{student.name} (Age: #{student.age})"
end

# Test belongs-to relationship (Student - Classroom)
puts "#{student1.name} belongs to #{student1.classroom.label}"

# Test Classroom setter for Student
student4 = Student.new(4, 16, classroom: classroom, name: 'Eve')
classroom.add_student(student4)
puts "Students in the classroom after adding #{student4.name}:"
classroom.students.each do |student|
  puts "#{student.name} (Age: #{student.age})"
end

# Test Student setter for Classroom
classroom1 = Classroom.new('Computer Science')
classroom2 = Classroom.new('Philosophy')
student4.classroom = classroom1
student3.classroom = classroom2
puts "#{student4.name} now belongs to #{student4.classroom.label}"

# Test Book and Person classes
book1 = Book.new('Clean Code', 'Robert Cecil Martin')
book2 = Book.new('Beyond Good and Evil: Prelude to a Philosophy of the Future', 'Friedrich Nietzsche')
person1 = Person.new(1, 30, name: 'John')
person2 = Person.new(2, 25, name: 'Franca')

# Rentals, many-to-many relationship (Person - Rentals, Book - Rentals)
Rental.new('2023-07-24', book1, student3)
Rental.new('2023-07-25', book2, person1)
Rental.new('2023-07-26', book1, person2)
Rental.new('2023-07-26', book1, student4)

puts "#{person1.name}'s rentals:"
person1.rentals.each do |rental|
  puts "Book: #{rental.book.title}, Date: #{rental.date}"
end

puts "#{book1.title}'s rentals:"
book1.rentals.each do |rental|
  puts "Person: #{rental.person.name}, Date: #{rental.date}"
end
