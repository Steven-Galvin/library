require 'spec_helper'

describe(Book) do
  describe('#==') do
    it ('is the same book if the titles are the same') do
      book1 = Book.new({:title => "Fault in Our Stars", :id => nil})
      book2 = Book.new({:title => "Fault in Our Stars", :id => nil})
      expect(book1 == book2).to(eq(true))
    end
  end

  describe('#title') do
    it('returns the book title') do
      book = Book.new({:title => "Fault in Our Stars", :id => nil})
      expect(book.title).to(eq('Fault in Our Stars'))
    end
  end

  describe('#id') do
    it('returns the book id') do
      book = Book.new({:title => "Fault in Our Stars", :id => nil})
      book.save
      expect(book.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a book to the array of saved books') do
      book = Book.new({:title => "Fault in Our Stars", :id => nil})
      book.save()
      expect(Book.all()).to(eq([book]))
    end
  end

  describe('.find') do
    it('returns a book by its id') do
      book1 = Book.new({:title => "Fault in Our Stars", :id => nil})
      book1.save()
      book2 = Book.new({:title => "Moby Dick", :id => nil})
      book2.save()
      expect(Book.find(book2.id)).to(eq(book2))
    end
  end

  describe('#delete') do
    it('lets you delete a book from the database') do
      book1 = Book.new({:title => "Fault in Our Stars", :id => nil})
      book1.save()
      book2 = Book.new({:title => "Moby Dick", :id => nil})
      book2.save()
      book1.delete()
      expect(Book.all()).to(eq([book2]))
    end
  end

  describe('#update') do
    it('lets you change the title of a book') do
      book = Book.new({:title => "Fault in Our Stars", :id => nil})
      book.save
      book.update({:title => "Fault in Our Stars, Volume 1", :id => nil})
      expect(book.title).to(eq("Fault in Our Stars, Volume 1"))
    end

    it('lets you add an author to a book') do
      book = Book.new({:title => "Fault in Our Stars", :id => nil})
      book.save
      author = Author.new({:name => "John Green", :id => nil})
      author.save
      book.update({:author_ids => [author.id]})
      expect(book.authors).to(eq([author]))
    end
  end

  describe('#authors') do
    it('returns all of the authors a particular book was written by') do
      book = Book.new({:title => "Fault in Our Stars", :id => nil})
      book.save
      author1 = Author.new({:name => "John Green", :id => nil})
      author1.save
      author2 = Author.new({:name => "Ernest Hemmingway", :id => nil})
      author2.save
      book.update({:author_ids => [author1.id, author2.id]})
      expect(book.authors).to(eq([author1, author2]))
    end
  end

  describe('.search_book') do
    it('returns a list of books from database') do
      book1 = Book.new({:title => "Fault in Our Stars", :id => nil})
      book1.save()
      book2 = Book.new({:title => "Moby Dick", :id => nil})
      book2.save()
    expect(Book.search_book("Moby Dick")).to(eq([book2]))
    end
  end
end
