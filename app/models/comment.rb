class Comment < ActiveRecord::Base
  
  after_save :calculate_average_for_work

  belongs_to :user
  belongs_to :work

  validates :rating, :text, presence: true
  validates :rating, inclusion: { in: 1..5 }
  
  def calculate_average_for_work
    average = Comment.where(work: self.work).average('rating')
    self.work.update(average: average.round(1))
  end

end
