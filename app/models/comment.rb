class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :work

  validates :rating, :text, presence: true
  validates :rating, inclusion: { in: 1..5 }

end
