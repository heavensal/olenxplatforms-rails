class Admin::IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to admin_idea_path(@idea), notice: 'Le projet a bien été mis à jour'
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    if @idea.destroy
      redirect_to admin_ideas_path, notice: 'Le projet a bien été supprimé'
    else
      redirect_to admin_ideas_path, alert: 'Impossible de supprimer le projet'
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description, :avatar)
  end

  def admin_only
    redirect_to root_path, alert: 'Vous n\'avez pas les droits nécessaires' unless current_user.admin?
  end
end
