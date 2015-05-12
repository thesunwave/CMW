class Comment < ActiveRecord::Base

  before_save :work_commented
  after_save :calculate_average_for_work

  belongs_to :user
  belongs_to :work

  validates :rating, :text, presence: true
  validates :rating, inclusion: { in: 0..5 }

  def calculate_average_for_work
    average = Comment.where(work: self.work).average('rating')
    self.work.update(average: average.round(1))
  end

  def work_commented
    if Comment.where(work_id: self.work, user_id: self.user.id).present?
      self.rating = nil
      return true
    end
  end

end
