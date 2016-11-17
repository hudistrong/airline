class User < ApplicationRecord
  rolify
  include Clearance::User
  attr_accessor :xls_file
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/default_avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  after_create_commit { ResetJob.perform_later }

  def self.authenticate(email, password)
    user = where(email: email).first
    user && user.authenticated?(password) ? user : nil
  end

  def shave_avatar
  	url = "public"+self.avatar.url(:medium).split("?").first
  	image = MiniMagick::Image.open(url)
  	w,h = image[:width],image[:height]
  	shaved_off = ((w-h)/2).round
  	image.shave "#{shaved_off}x0"
  	image.resize "40x40"
  	image.write(url)
  end
end
