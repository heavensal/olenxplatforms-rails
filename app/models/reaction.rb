class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  validates :user_id, uniqueness: { scope: :idea_id }
  validates :reaction_type, presence: true
  validates :reaction_type, inclusion: { in: %w[like dislike] }

  def self.like
    where(reaction_type: "like")
  end

  def self.dislike
    where(reaction_type: "dislike")
  end
end
