class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :upsert_reaction, only: [ :create, :update ]

  def create
    if @reaction.save
      redirect_to idea_path(@reaction.idea), notice: "Vous avez réagi à cette idée de projet"
    else
      redirect_to idea_path(@reaction.idea), alert: "Impossible de réagir à cette idée de projet"
    end
  end

  def update
    if @reaction.update(reaction_params)
      redirect_to idea_path(@reaction.idea), notice: "Vous avez réagi à cette idée de projet"
    else
      redirect_to idea_path(@reaction.idea), alert: "Impossible de réagir à cette idée de projet"
    end
  end

  def destroy
    @reaction = @current_user.reactions.find(params[:id])
    if @reaction.destroy
      redirect_to idea_path(@reaction.idea), notice: "Votre réaction a bien été supprimée"
    else
      redirect_to idea_path(@reaction.idea), alert: "Impossible de supprimer votre réaction"
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(:reaction_type, :idea_id)
  end

  def upsert_reaction
    @reaction = current_user.reactions.find_or_initialize_by(idea_id: reaction_params[:idea_id])
    @reaction.reaction_type = reaction_params[:reaction_type]
  end
end
