require("rspec")
require("pg")
require("author")
require("book")
require("patron")

DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM patron *;")
    DB.exec("DELETE FROM authors_books *;")
    DB.exec("DELETE FROM check_out *;")
  end
end
