class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs
  require_all './app/models/modules'
  include Slug_Instance
  extend Slug_Class
end
