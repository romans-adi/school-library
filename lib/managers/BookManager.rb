require_relative '../models/Book'

class BookManager
  def initialize
    @books = []
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    book
  end

  def list_all_books
    list_items(@books)
  end

  def find_book_by_index(index)
    @books[index - 1] if index.positive? && index <= @books.length
  end

  def list_items(items)
    if items.empty?
      puts 'No books available.'
    else
      items.each_with_index do |item, index|
        puts "#{index + 1}. #{book_display_text(item)}"
      end
    end
  end

  private

  def book_display_text(book)
    "#{book.title} by #{book.author}"
  end
end
