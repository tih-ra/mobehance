require 'open-uri'
class DbPhoto < ActiveRecord::Base
  attr_accessor :image_url
  
  belongs_to :db_project
  has_attached_file :img, :styles => { :android => "400x400>" }
  
  before_validation :download_remote_image, :if => :image_url_provided?

  validates_presence_of :img_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'

  private

    def image_url_provided?
      !self.image_url.blank?
    end

    def download_remote_image
      self.img = do_download_remote_image
      self.img_remote_url = image_url
    end

    def do_download_remote_image
      io = open(URI.parse(image_url))
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
    end
end
