class KanbansController < ApplicationController
  # GET /kanbans
  # GET /kanbans.json
  # def index
  #   @kanbans = Kanban.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @kanbans }
  #   end
  # end

  # GET /kanbans/1
  # GET /kanbans/1.json
  def show
    @kanban = Kanban.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kanban }
    end
  end

  # GET /kanbans/new
  # GET /kanbans/new.json
  # def new
  #   @kanban = Kanban.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @kanban }
  #   end
  # end

  # GET /kanbans/1/edit
  def edit
    @kanban = Kanban.find(params[:id])
  end

  # POST /kanbans
  # POST /kanbans.json
  # def create
  #   @kanban = Kanban.new(params[:kanban])
  # 
  #   respond_to do |format|
  #     if @kanban.save
  #       format.html { redirect_to @kanban, notice: 'Kanban was successfully created.' }
  #       format.json { render json: @kanban, status: :created, location: @kanban }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @kanban.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /kanbans/1
  # PUT /kanbans/1.json
  def update
    @kanban = Kanban.find(params[:id])

    respond_to do |format|
      if @kanban.update_attributes(params[:kanban])
        format.html { redirect_to @kanban, notice: 'Kanban was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @kanban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kanbans/1
  # DELETE /kanbans/1.json
  # def destroy
  #   @kanban = Kanban.find(params[:id])
  #   @kanban.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to kanbans_url }
  #     format.json { head :ok }
  #   end
  # end
end
