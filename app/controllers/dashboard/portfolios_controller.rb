class Dashboard::PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def show
    @portfolio = Portfolio.includes(:ideas, :projects)
    .with_attached_avatar
    .with_attached_qr_code
    .find_by!(user: current_user)
  end

  def edit
    @portfolio = current_user.portfolio
  end

  def update
    @portfolio = current_user.portfolio
    if @portfolio.update(portfolio_params)
      redirect_to dashboard_portfolio_path, notice: "Le portfolio a bien été mis à jour"
    else
      render :edit
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:company_name, :description, :avatar)
  end
end
