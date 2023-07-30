class TeacherInputHandler
  def self.prompt_for_data
    puts 'Creating a teacher...'
    print 'Age: '
    age = integer_input

    print 'Name: '
    name = gets.chomp

    print 'Specialization: '
    specialization = gets.chomp

    { type: :teacher, age: age, name: name, specialization: specialization }
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
