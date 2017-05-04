class Author
  attr_accessor(:name, :id)

  def initialize (attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(another_author)
    self.name == another_author.name
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def self.find (id)
    result = DB.exec("SELECT * FROM authors WHERE id = #{id};")
    name = result.first().fetch("name")
    Author.new({:name => name, :id => id})
  end

  def update (attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:book_ids, []).each do |book_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{self.id}, #{book_id});")
    end
  end

  def books
    author_books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{self.id};")
    results.each do |result|
      book_id = result.fetch("book_id").to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first.fetch("title")
      author_books.push(Book.new({:title => title, :id => book_id}))
    end
    author_books
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{self.id}")
  end

  def self.search_author (search)
    searched_authors = []
    authors = DB.exec("SELECT * FROM authors WHERE LOWER(name) LIKE LOWER('#{search}%');")
    authors.each do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i
      searched_authors.push(Author.new({:name => name, :id => id}))
    end
    searched_authors
  end

end
