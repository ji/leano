class Kanban < ActiveRecord::Base
  belongs_to :project
  has_many :columns
  has_many :user_stories
  
  def initialize(*params)
    super(*params)
    
    column = Column.new
    column.name = "Backlog"
    column.kanban_id = self.id
    self.columns.push(column)
    
    column = Column.new
    column.name = "Archive"
    column.kanban_id = self.id
    self.columns.push(column)
  end

  def setup_default_column_set
    add_column_with_name("Planned")
    add_column_with_name("In Progress")
    add_column_with_name("Completed")
  end

  def add_column_with_name(column_name)
    column = Column.new
    column.name = column_name
    column.kanban_id = self.id
    self.columns.insert(self.columns.count - 1, column)
    self.save
  end
end
