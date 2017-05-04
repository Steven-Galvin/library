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

get("/books/search/:id") do
  @book = Book.find(params.fetch("id").to_i())

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

get("/authors/search/:id") do
 @author = Author.find(params.fetch("id").to_i())

  erb(:author_info)
end
