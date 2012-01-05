class Kanban < ActiveRecord::Base
  belongs_to :project
  has_many :columns
  has_many :user_stories
  
  def initialize(*params)
    super(*params)
    setup_initial_columns
  end

  def setup_default_column_set
    if self.columns.count == 0
      setup_initial_columns
    end
    
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

  def user_stories_for_column(column)
    user_stories = UserStory.where("column_id = ?", column.id)
    return user_stories
  end
protected
  def setup_initial_columns
    column = Column.new
    column.name = "Backlog"
    column.kanban_id = self.id
    self.columns.push(column)
    
    column = Column.new
    column.name = "Archive"
    column.kanban_id = self.id
    self.columns.push(column)
  end
end
