class Book
  attr_reader(:title, :due_date, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @due_date = attributes.fetch(:due_date)
    @id = attributes.fetch(:id)
  end
end
