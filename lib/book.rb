class Book
  attr_accessor(:title, :author_id, :id)

  def initialize (attributes)
    @title = attributes.fetch(:title)
    @author_id = attributes.fetch(:author_id)
    @id = attributes.fetch(:id)
  end

  def == (another_book)
    self.title == another_book.title
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |book|
      title = book.fetch('title')
      author_id = book.fetch('author_id').to_i
      id = book.fetch('id').to_i
      books.push(Book.new({:title => title, :author_id => author_id, :id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@title}', #{@author_id}) RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def self.find (id)
    found_book = nil
    Book.all.each do |book|
      if book.id == id
        found_book = book
      end
    end
    found_book
  end

  def update_title (attributes)
    @title = attributes.fetch(:title)
    @id = self.id
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end
end
