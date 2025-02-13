class Project < ApplicationRecord
  belongs_to :portfolio

  has_one_attached :avatar

  validates :title, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[title description]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
