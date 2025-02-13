class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :portfolio, dependent: :destroy
  has_many :ideas, through: :portfolio
  has_many :projects, through: :portfolio
  has_many :reactions, dependent: :destroy

  validates :role, inclusion: { in: %w[user admin] }

  after_create :create_portfolio

  def admin?
    role == 'admin'
  end
end
