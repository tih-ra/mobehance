class Category
  include ActiveModel::Serialization
  attr_accessor :name, :url
  def initialize(name, url)
        @name, @url = name, url
  end
  def self.preCollect pst
    pst.map{|c| self.new(c.text, c[:href][/\d+/])}
  end
end