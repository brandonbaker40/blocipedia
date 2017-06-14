class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]

  # POST /collaborators
  def create
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.build(user_id: params[:collaborator][:user_id])
    #binding.pry

    # if collaborator.save
    # 	flash[:notice] = "#{collaborator.user.email} is now a collaborator on your wiki."
    # else
    # 	flash[:alert] = "Collaborator failed."
    # end

    if wiki.collaborators.exists?(user_id: params[:collaborator][:user_id])
      flash[:alert] = "Collaborator already added."
    elsif collaborator.save
      flash[:notice] = "#{collaborator.user.email} is now a collaborator on your wiki."
    else
      flash[:alert] = "Collaborator failed."
    end

  	redirect_to edit_wiki_path(wiki)
  end

  # DELETE /collaborators/1
  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])

    if @collaborator.destroy
    	flash[:notice] = "Collaborator was successfully removed."
    else
    	flash[:alert] = "Collaborator was NOT removed."
    end

  	redirect_to edit_wiki_path(@wiki)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaborator
      @collaborator = Collaborator.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def collaborator_params
      params[:collaborator]
      #params.require(:user_id, :wiki_id)
    end
end
