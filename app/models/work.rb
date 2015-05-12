require 'elasticsearch/model'

class Work < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
  #has_many :imagefiles

  has_attached_file :image, styles: {
    thumb: '200x200#',
    square: '300x300#',
    medium: '768x768>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type =>  /^image\/(png|gif|jpeg|jpg)/

  validates :title, :description, :image, presence: true

#  before_create :normalize_filename
  before_create :capitalize

#  def normalize_filename
#    Paperclip.interpolates :normalized_filename do |attachment, style|
#      attachment.instance.normalized_filename
#    end
#
#    def normalized_filename
#      "#{user.username}-#{self.id}"
#    end
#  end

  # elasticsearch method for autosync
  Work.import

  def self.search(query)
  __elasticsearch__.search(
    {
      query: {
        multi_match: {
          query: query,
          fuzziness: 0.005,
          prefix_length: 2,
          operator: "and",
          max_expansions: 999,
          fields: ['description', 'title']
          }
      },
      highlight: {
      pre_tags: ['<em>'],
      post_tags: ['</em>'],
      fields: {
        title: {},
        description: {}
      },
    }
  })
  end

private

  def capitalize
    self.title.capitalize!
    self.description.capitalize!
  end
end
