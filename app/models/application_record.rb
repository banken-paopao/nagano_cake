class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def tag_save(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    new_tags.each do |new|
      tag = Tag.find_or_create_by(name: new)
      self.tags << tag
    end
  end
end
