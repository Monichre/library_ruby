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
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end
end
