module Slug_Instance
  def slug
    self.name.split(' ').collect {|word| word.downcase}.join('-')
  end

  def self.find_by_slug(slug)
    self.find_by name: slug.split('-').join(' ').titleize
  end
end
