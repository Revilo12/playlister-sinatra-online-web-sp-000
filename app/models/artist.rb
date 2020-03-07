class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs
  require_all './app/models/modules'
  include Slug_Instance
  extend Slug_Class
end
