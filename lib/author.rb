class Author
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(another_author)
    self.name() == another_author.name() && (self.id() == another_author.id())
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM authors WHERE id = #{id};")
    name = result.first().fetch('name')
    Author.new({:name => name, :id => id})
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:book_ids, []).each do |book_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{self.id()}, #{book_id});")
    end
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
  end

  def books
    the_books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{self.id()};")
    results.each do |result|
      book_id = result.fetch('book_id').to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch('title')
      due_date = book.first().fetch('due_date')
      the_books.push(Book.new({:title => title, :id => book_id, :due_date => due_date}))
    end
    the_books
  end
end
