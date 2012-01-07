class ProjectsController < ApplicationController
  before_filter :check_authenticated_user
  before_filter :fetch_project_by_id,         :only => [:show, :edit, :update, :destroy]
  before_filter :check_ownership,             :only => [:show, :edit, :update, :destroy]
  
  # GET /projects
  # GET /projects.json
  def index
    @projects = @logged_user.projects
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    
    @project.users<< @logged_user
    
    kanban = Kanban.new
    kanban.title = @project.title

    kanban.setup_default_column_set if params[:default_kanban_column_set]

    kanban.project = @project
    @project.kanban = kanban
    
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
  
protected

  def check_ownership
    unless @project.belongs_to_user? @logged_user
      redirect_to login_url, notice: "You don't have permission to view this content."
    end
  end
  
  def fetch_project_by_id
    @project = Project.find(params[:id])
  end
end
