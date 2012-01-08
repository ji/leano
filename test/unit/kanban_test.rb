require 'test_helper'

class KanbanTest < ActiveSupport::TestCase
  test "should add a column with title 'Test'" do
    kanban = Kanban.new
    kanban.add_column_with_name("Test")
    kanban_columns = kanban.columns
    
    assert kanban_columns.count == 3, 'Number of columns should be three for a default kanban.'
    assert kanban_columns[1].name == "Test"
  end
  
  test "should create kanban with a default column set" do
    kanban = Kanban.new
    kanban.setup_default_column_set
    kanban_columns = kanban.columns
    
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
  
  test "should return only user stories of a certain column" do
    kanban = Kanban.new
    kanban.setup_default_column_set
    target_column = kanban.columns.first
    
    user_story = UserStory.new
    user_story.column_id = target_column.id
    user_story.save
    
    target_column_user_stories = kanban.user_stories_for_column(target_column)
    
    assert target_column_user_stories.count == 1, "Only one user story expected to be in the target array. #{target_column_user_stories.count} found instead."
    assert target_column_user_stories.first == user_story, "The user story contained in the result array does not belong to the target column."
  end
  
  test "should auto create default coloumns" do
    kanban = Kanban.new()
    
    assert kanban.columns.count > 0, "New Kanban should come with at least one column"
  end
end
