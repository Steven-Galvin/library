class Book
  attr_accessor(:title, :id)

  def initialize (attributes)
    @title = attributes.fetch(:title)
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
      id = book.fetch('id').to_i
      books.push(Book.new({:title => title, :id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def self.find (id)
    result = DB.exec("SELECT * FROM books WHERE id = #{id};")
    title = result.first().fetch("title")
    Book.new({:title => title, :id => id})
  end

  def update (attributes)
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id};")

    attributes.fetch(:author_ids, []).each() do |author_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id});")
    end
  end

  def authors
    book_authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id};")
    results.each do |result|
      author_id = result.fetch("author_id").to_i
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      name = author.first.fetch("name")
      book_authors.push(Author.new({:name => name, :id => author_id}))
    end
    book_authors
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end

  def self.search (search)
    searched_books = []
    books = DB.exec("SELECT * FROM books WHERE title LIKE '#{search}%';")
    books.each do |book|
      title = book.fetch('title')
      id = book.fetch('id').to_i
      searched_books.push(Book.new({:title => title, :id => id}))
    end
    searched_books
  end
end
