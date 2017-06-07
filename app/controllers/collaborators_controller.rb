class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]

  # GET /collaborators
  def index
    @collaborators = Collaborator.all
  end

  # GET /collaborators/1
  def show
  end

  # GET /collaborators/new
  def new
    @collaborator = Collaborator.new
  end

  # GET /collaborators/1/edit
  def edit
  end

  # POST /collaborators
  def create
    @collaborator = Collaborator.new(collaborator_params)

    if @collaborator.save
      redirect_to @collaborator, notice: 'Collaborator was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /collaborators/1
  def update
    if @collaborator.update(collaborator_params)
      redirect_to @collaborator, notice: 'Collaborator was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /collaborators/1
  def destroy
    @collaborator.destroy
    redirect_to collaborators_url, notice: 'Collaborator was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaborator
      @collaborator = Collaborator.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def collaborator_params
      params[:collaborator]
    end
end
