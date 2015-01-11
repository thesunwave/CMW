class Work < ActiveRecord::Base  
  resourcify
  belongs_to :user
  belongs_to :image_file, dependent: :destroy

  validates :image_file, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :user, presence: true										# проверяем целостность связи с пользователем

  before_create :before_create_handler
  after_save :after_save_handler

end
