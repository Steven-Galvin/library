require "rspec"
require "pg"
require "book"
require "user"

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM books *;')
    # DB.exec('DELETE FROM users *;')
  end
end
