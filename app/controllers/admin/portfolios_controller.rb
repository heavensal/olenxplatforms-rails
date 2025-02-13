class Admin::PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @portfolios = Portfolio.all
  end

  def show
    @portfolio = Portfolio.includes(:ideas, :projects).with_attached_avatar.with_attached_qr_code.find(params[:id])
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.update(portfolio_params)
      redirect_to admin_portfolio_path(@portfolio), notice: "Le portfolio a bien été mis à jour"
    else
      render :edit
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.destroy
      redirect_to admin_portfolios_path, notice: "Le portfolio a bien été supprimé"
    else
      redirect_to admin_portfolios_path, alert: "Impossible de supprimer le portfolio"
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name, :description, :avatar)
  end

  def admin_only
    redirect_to root_path, alert: "Vous n'avez pas les droits nécessaires" unless current_user.admin?
  end
end
