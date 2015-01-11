class Avatar < ActiveRecord::Base
	has_attached_file :avatar,
										url: "/img/avatars/:hash_:style.:extension",
										hash_secret: "k&hsdk28hvnmaabc5248sdLKJsd9892jd_);l*hs3",
                    styles: { :small => "100x100#", :large => "500x500>" },
                    processors: [:cropper]

	# File vaildations
	validates_attachment_presence 			:avatar
	validates_attachment_content_type 	:avatar, content_type: ["image/jpeg", "image/jpg", "image/png"], 
	                                		:message => 'file must be image'
	validates_attachment_size 					:avatar, :in => 0..5.megabytes

  after_update :reprocess_avatar, :if => :cropping?
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
private  
  def reprocess_avatar
    avatar.reprocess!
  end

end
