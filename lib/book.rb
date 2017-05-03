class Book
  attr_accessor(:title, :author, :id)

  def initialize (attributes)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
  end

  def == (another_book)
    self.title == another_book.title
    self.author == another_book.author
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      id = book.fetch('id').to_i
      books.push(Book.new({:title => title, :author => author, :id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end
end
