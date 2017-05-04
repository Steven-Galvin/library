require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require './lib/author'
require 'pry'
require 'pg'

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "library_test"})

get ('/') do
  @authors = Author.all
  @books = Book.all
  erb(:index)
end

get '/books' do
  @books = Book.all
  erb(:books)
end

get '/authors' do
  @authors = Author.all
  erb(:authors)
end

post '/books' do
  title = params.fetch('title')
  book = Book.new({:title => title, :id => nil})
  book.save
  @books = Book.all
  erb(:books)
end

post '/book/search' do
  book = params.fetch('search')
  @books = Book.search_book(book)
  erb(:book_search_results)
end

get("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @authors = Author.all
  erb(:book_info)
end

get("/books/search/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @authors = Author.all
  erb(:book_info)
end

patch("/books/:id") do
  book_id = params.fetch('id').to_i
  @book = Book.find(book_id)
  author_ids = params.fetch('author_ids')
  @book.update({:author_ids => author_ids})
  @authors = Author.all
  erb(:book_info)
end

patch("/books/search/:id") do
  book_id = params.fetch('id').to_i
  @book = Book.find(book_id)
  author_ids = params.fetch('author_ids')
  @book.update({:author_ids => author_ids})
  @authors = Author.all
  erb(:book_info)
end

post '/authors' do
  name = params.fetch('name')
  author = Author.new({:name => name, :id => nil})
  author.save
  @authors = Author.all
  erb(:authors)
end

post '/author/search' do
  author = params.fetch('search')
  @authors = Author.search_author(author)
  erb(:author_search_results)
end

get("/authors/:id") do
  @author =      Author.find(params.fetch("id").to_i())
  @books = Book.all
  erb(:author_info)
end

get("/authors/search/:id") do
  @author =      Author.find(params.fetch("id").to_i())
  @books = Book.all
  erb(:author_info)
end

patch("/authors/:id") do
  author_id = params.fetch('id').to_i
  @author = Author.find(author_id)
  book_ids = params['book_ids']
  @author.update({:book_ids => book_ids})
  @books = Book.all
  erb(:author_info)
end

patch("/authors/search/:id") do
  author_id = params.fetch('id').to_i
  @author = Author.find(author_id)
  book_ids = params['book_ids']
  @author.update({:book_ids => book_ids})
  @books = Book.all
  erb(:author_info)
end
