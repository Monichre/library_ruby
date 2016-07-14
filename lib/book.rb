class Book
  attr_reader(:title, :due_date, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @due_date = attributes.fetch(:due_date)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      id = book.fetch('id').to_i
      due_date = book.fetch('due_date')
      books.push(Book.new({:title => title, :id => id, :due_date => due_date}))
    end
    books
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM books WHERE id = #{id};")
    title = result.first().fetch('title')
    due_date = result.first().fetch('due_date')
    Book.new({:title => title, :id => id, :due_date => due_date})
  end

  def save
    result = DB.exec("INSERT INTO books (title, due_date) VALUES ('#{title}', '#{due_date}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  def ==(another_book)
    self.title() == another_book.title() && (self.id() == another_book.id())
  end

  def update(attributes)
    @title = attributes.fetch(:title, @title)
    @due_date = attributes.fetch(:due_date, @due_date)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")

    attributes.fetch(:author_ids, []).each do |author_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
    end
  end

  def authors
    book_authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id()};")
    results.each do |result|
      author_id = result.fetch('author_id').to_i
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      name = author.first().fetch('name')
      book_authors.push(Author.new({:name => name, :id => author_id}))
    end
    book_authors
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end
end
