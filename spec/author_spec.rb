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
      author = Author.new({:name => "Dan Brown", :id => nil})
      author.save()
      author.update({:name => 'Dan Phillipe'})
      expect(author.name()).to(eq('Dan Phillipe'))
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
