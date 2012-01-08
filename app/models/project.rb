class Project < ActiveRecord::Base
  has_many :contributors
  has_many :users, :through => :contributors
  
  has_one :kanban
  validates_presence_of :title
  
  before_destroy { |project| project.kanban.destroy }
  
  def belongs_to_user?(user)
    Contributor.count(:all, conditions: {project_id: self.id, user_id: user.id}) > 0
  end
  
  def initialize(*params)
    super(*params)
    setup_kanban
  end
  
  def setup_kanban
    self.kanban = Kanban.new(title: title)
  end
end
