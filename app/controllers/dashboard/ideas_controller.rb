class Dashboard::IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio, only: %i[index show new create edit update destroy]


  def index
    @ideas = @portfolio.ideas.with_attached_avatar.order(updated_at: :desc)
  end

  def show
    @idea = @portfolio.ideas.with_attached_avatar.find(params[:id])
    @reaction = current_user.reactions.find_by(idea: @idea) if user_signed_in?
  end

  def new
    @idea = @portfolio.ideas.new
  end

  def create
    @idea = @portfolio.ideas.new(idea_params)
    if @idea.save
      redirect_to dashboard_portfolio_idea_path(@idea), notice: "L'idée a bien été créée"
    else
      render :new
    end
  end

  def edit
    @idea = @portfolio.ideas.find(params[:id])
  end

  def update
    @idea = @portfolio.ideas.find(params[:id])
    if @idea.update(idea_params)
      redirect_to dashboard_portfolio_idea_path(@idea), notice: "L'idée de projet a bien été mise à jour"
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    if @idea.destroy
      redirect_to dashboard_portfolio_ideas_path(@portfolio), notice: "L'idée de projet a bien été supprimée"
    else
      render :edit, alert: "Impossible de supprimer l'idée"
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description, :avatar)
  end

  def set_portfolio
    @portfolio = current_user.portfolio
  end
end
