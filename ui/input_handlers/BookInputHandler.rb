class BookInputHandler
  def self.prompt_for_data
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    { title: title, author: author }
  end
end
