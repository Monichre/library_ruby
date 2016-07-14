require('spec_helper')

describe(Book) do


  describe('.all') do
    it "starts off with no books" do
      expect(Book.all()).to(eq([]))
    end

    it "has all books in in it" do
      due_date = '2017-01-01'
      test_book = Book.new({:title => 'The Sun Also Rises', :id => nil, :due_date => due_date})
      test_book.save()
      test_book2 = Book.new({:title => 'The Raven', :id => nil, :due_date => due_date})
      test_book2.save()
      expect(Book.all()).to(eq([test_book, test_book2]))
    end
  end

  describe('.find') do
    it "returns a book by its ID number" do
      due_date = '2017-01-01'
      test_book = Book.new({:title => 'The Sun Also Rises', :id => nil, :due_date => due_date})
      test_book.save()
      test_book2 = Book.new({:title => 'The Raven', :id => nil, :due_date => due_date})
      test_book2.save()
      expect(Book.find(test_book.id())).to(eq(test_book))
    end
  end

  describe('#==') do
    it "is the same book if it has the same title and id" do
      due_date = '2017-01-01'
      test_book = Book.new({:title => 'The Sun Also Rises', :id => nil, :due_date => due_date})
      test_book2 = Book.new({:title => 'The Sun Also Rises', :id => nil, :due_date => due_date})
      expect(test_book).to(eq(test_book2))
    end
  end

  describe('#authors') do
    it "returns all of the authors for a particular book" do
      due_date = '2017-01-01'
      test_book = Book.new({:title => 'The Sun Also Rises', :id => nil, :due_date => due_date})
      test_book.save()
      author = Author.new({:name =>'Ernest Hemingway', :id => nil})
      author.save()
      test_book.update({:title => "For Whom the Bell Tolls", :author_ids => [author.id()]})
      expect(test_book.authors()).to(eq([author]))
    end
  end

  describe('#update') do
    it "lets you update books in the database" do
      due_date = '2017-01-01'
      test_book = Book.new({:title => 'The Sun Also Rises', :id => nil, :due_date => due_date})
      test_book.save()
      author = Author.new({:name =>'Ernest Hemingway', :id => nil})
      author.save()
      test_book.update({:title => "For Whom the Bell Tolls", :author_ids => [author.id()]})
      expect(test_book.title()).to(eq("For Whom the Bell Tolls"))
      expect(test_book.authors()).to(eq([author]))
    end
  end

  describe('#delete') do
    it "lets you delete books in the database" do
      due_date = '2017-01-01'
      test_book1 = Book.new({:title => 'The Sun Also Rises', :id => nil, :due_date => due_date})
      test_book1.save()
      test_book2 = Book.new({:title => 'For Whom the Bell Tolls', :id => nil, :due_date => due_date})
      test_book2.save()
      test_book1.delete()
      expect(Book.all()).to(eq([test_book2]))
    end
  end
end
