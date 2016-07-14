require('spec_helper')

describe(Author) do

  describe('.all') do
    it "starts off with no authors" do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('.find') do
    it "returns a movie by its ID number" do
      test_author = Author.new({:name => "Mark Twain", :id => nil})
      test_author.save()
      test_author2 = Author.new({:name => "Ernest Hemmingway", :id => nil})
      test_author2.save()
      expect(Author.find(test_author2.id())).to(eq(test_author2))
    end
  end

  describe('#save') do
    it "text" do
      #write some save test code
    end
  end

  describe('#update') do
    it "lets you update an author in the author database" do
      due_date = '2017-01-01'
      author = Author.new({:name => "Dan Brown", :id => nil})
      author.save()
      author.update({:name => 'Dan Phillipe'})
      expect(author.name()).to(eq('Dan Phillipe'))
    end

    it "lets you update/add a book to the author" do
      due_date = '2017-01-01'
      author = Author.new({:name => "Dan Brown", :id => nil})
      author.save()
      book = Book.new({:title => "Angels and Demons", :id => nil, :due_date => due_date})
      book.save()
      author.update({:book_ids => [book.id()]})
      expect(author.books()).to(eq([book]))
    end
  end

  describe('#books') do
    it "returns all the books attributed to that author" do
      due_date = '2017-01-01'
      author = Author.new({:name => "Dan Brown", :id => nil})
      author.save()
      book = Book.new({:title => "Angels and Demons", :id => nil, :due_date => due_date})
      book.save()
      book2 = Book.new({:title => "The Da Vinci Code", :id => nil, :due_date => due_date})
      book2.save()
      author.update({:book_ids => [book.id()]})
      author.update({:book_ids => [book2.id()]})
      expect(author.books()).to(eq([book, book2]))
    end
  end

  describe('#delete') do
    it "lets you an author from the database" do
      author = Author.new({:name => 'Dan Brown', :id => nil})
      author.save()
      author2 = Author.new({:name => 'Jean Paul Sartes', :id => nil})
      author2.save()
      author.delete()
      expect(Author.all()).to(eq([author2]))
    end
  end
end
