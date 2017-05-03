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

end
