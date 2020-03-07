module Slug_Class
  def find_by_slug(slug)
    # self.find_by name: slug.split('-').join(' ').titleize
    self.all.find do |instance|
      instance.slug == slug
    end
  end
end
