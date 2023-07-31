require_relative '../../ui/input_handlers/BookInputHandler'

class CreateBookHandler
  def initialize(app)
    @app = app
  end

  def handle
    book_data = BookInputHandler.prompt_for_data
    book = @app.create_book(book_data[:title], book_data[:author])
    return unless book

    puts "Book #{book.title} created successfully"
  end
end
