require 'spec_helper'

describe(Book) do
  describe('#==') do
    it ('is the same book if the title and author are the same') do
      book1 = Book.new({:title => "Fault in Our Stars", :author => "John Green", :id => nil})
      book2 = Book.new({:title => "Fault in Our Stars", :author => "John Green", :id => nil})
      expect(book1 == book2).to(eq(true))
    end
  end

  describe('#title') do
    it('returns the book title') do
      book1 = Book.new({:title => "Fault in Our Stars", :author => "John Green", :id => nil})
      expect(book1.title).to(eq('Fault in Our Stars'))
    end
  end

  describe('#author') do
    it('returns the book author') do
      book1 = Book.new({:title => "Fault in Our Stars", :author => "John Green", :id => nil})
      expect(book1.author).to(eq('John Green'))
    end
  end

  describe('#id') do
    it('returns the book id') do
      book1 = Book.new({:title => "Fault in Our Stars", :author => "John Green", :id => nil})
      book1.save
      expect(book1.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a book to the array of saved books') do
      book1 = Book.new({:title => "Fault in Our Stars", :author => "John Green", :id => nil})
      book1.save()
      expect(Book.all()).to(eq([book1]))
    end
  end
end
