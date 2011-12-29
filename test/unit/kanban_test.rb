require 'test_helper'

class KanbanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should add a column with title 'Test'" do
    kanban = Kanban.new
    kanban.add_column_with_name("Test")
    kanban_columns = kanban.columns
    
    assert kanban_columns.count == 3, 'Number of columns should be three for a default kanban.'
    assert kanban_columns[1].name == "Test"
  end
  
  test "should create default kanban" do
    kanban = Kanban.new
    kanban_columns = kanban.columns
    
    kanban.add_column_with_name('Planned')
    kanban.add_column_with_name('In Progress')
    kanban.add_column_with_name('Completed')
    
    assert kanban_columns.count == 5, 'Number of columns should be five for a default kanban.'
    assert kanban_columns[0].name == "Backlog", 'First column\'s title is not Backlog.'
    assert kanban_columns[1].name == "Planned", 'Second column\'s title is not Planned.'
    assert kanban_columns[2].name == "In Progress", 'Third column\'s title is not In Progress.'
    assert kanban_columns[3].name == "Completed", 'Forth column\'s title is not Completed.'
    assert kanban_columns[4].name == "Archive", 'Fifth column\'s title is not Archive.'
  end
  
  test "should create custom kanban" do
    kanban = Kanban.new
    kanban_columns = kanban.columns
    
    assert kanban_columns.count == 2, 'Number of columns should be two for a custom kanban'
    assert kanban_columns.first.name == "Backlog", 'First column\'s title is not Backlog.'
    assert kanban_columns.last.name == "Archive", 'Second column\'s title is not Archive.'
  end
end
