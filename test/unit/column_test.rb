require 'test_helper'

class ColumnTest < ActiveSupport::TestCase
  test "should auto destroy associated objects" do
    column = Column.new(name: "Backlog")
    column.user_stories<< UserStory.new
    
    assert column.save, "Column should save #{column.errors.full_messages}"
    
    column_id = column.id
    column.destroy
    assert UserStory.count(:all, conditions: {column_id: column_id}) == 0, "Destroying a column should auto destroy associated user stories"
  end
end
