require 'spec_helper'

describe(Author) do
  describe('#==') do
    it ('is the same author if the name is the same') do
      author1 = Author.new({:name => "John Green", :id => nil})
      author2 = Author.new({:name => "John Green", :id => nil})
      expect(author1 == author2).to(eq(true))
    end
  end

  describe('#name') do
    it('returns the name of the author') do
      author1 = Author.new({:name => "John Green", :id => nil})
      expect(author1.name).to(eq('John Green'))
    end
  end

  describe('#id') do
    it('returns the author id') do
        author1 = Author.new({:name => "John Green", :id => nil})
      author1.save
      expect(author1.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".all") do
    it('starts with an empty array') do
      expect(Author.all).to(eq([]))
    end
  end

  describe("#save") do
    it("adds an author to the authors array") do
      author1 = Author.new({:name => "John Green", :id => nil})
      author1.save
      expect(Author.all).to(eq([author1]))
    end
  end

  describe(".find") do
    it("finds an author by their id") do
      author1 = Author.new({:name => "John Green", :id => nil})
      author1.save
      author2 = Author.new({:name => "Ernest Hemmingway", :id => nil})
      author2.save
      expect(Author.find(author2.id)).to(eq(author2))
    end
  end

  describe("#update") do
    it("lets you update authors in the database") do
      author = Author.new({:name => "John Green", :id => nil})
      author.save
      author.update({:name => "Ernest Hemmingway", :id => nil})
      expect(author.name).to(eq("Ernest Hemmingway"))
    end

    it("lets you add a book to an author") do
      book = Book.new({:title => "Fault in Our Stars", :id => nil})
      book.save
      author = Author.new({:name => "John Green", :id => nil})
      author.save
      author.update({:book_ids => [book.id]})
      expect(author.books).to(eq([book]))
    end
  end

  describe("#books") do
    it("returns all of the books written by a particular author") do
      book1 = Book.new({:title => "Fault in Our Stars", :id => nil})
      book1.save
      book2 = Book.new({:title => "Looking for Alaska", :id => nil})
      book2.save
      author = Author.new({:name => "John Green", :id => nil})
      author.save
      author.update({:book_ids => [book1.id, book2.id]})
      expect(author.books).to(eq([book1, book2]))
    end
  end


  describe("#delete") do
    it('lets you delete an author from the database') do
      author1 = Author.new({:name => "John Green", :id => nil})
      author1.save
      author2 = Author.new({:name => "Ernest Hemmingway", :id => nil})
      author2.save
      author1.delete
      expect(Author.all()).to(eq([author2]))
    end
  end
end
