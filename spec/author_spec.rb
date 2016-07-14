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
end
