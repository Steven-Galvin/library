require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require './lib/patron'
require 'pry'
require 'pg'

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end
