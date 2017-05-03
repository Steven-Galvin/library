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
    found_author = nil
    Author.all.each do |author|
      if author.id == id
        found_author = author
      end
    end
    found_author
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{self.id}")
  end

end
