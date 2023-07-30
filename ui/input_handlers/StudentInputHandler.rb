class StudentInputHandler
  def self.prompt_for_data
    puts 'Creating a student...'
    print 'Age: '
    age = integer_input

    print 'Name: '
    name = gets.chomp

    print 'Classroom: '
    classroom = gets.chomp
    parent_permission = age < 18 ? ask_parent_permission : true

    { type: :student, age: age, name: name, classroom: classroom, parent_permission: parent_permission }
  end

  def self.integer_input
    input = gets.chomp
    until input.match?(/^\d+$/)
      print 'Please enter a valid age (numeric value): '
      input = gets.chomp
    end
    input.to_i
  end

  def self.ask_parent_permission
    print 'Has parent permission? [Y/n]: '
    permission = gets.chomp.downcase
    permission == 'y'
  end
end
