class Others::PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @portfolios = Portfolio.with_attached_avatar.all
    @ideas = Idea.with_attached_avatar.order(updated_at: :desc)
  end
end
