class Album < ApplicationRecord
  has_one_attached :cover_image
  has_many_attached :images
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.ransackable_attributes(_auth_object = nil)
    %w[description created_at id publish title updated_at]
  end

  def self.tagged_with(name)
    tag = Tag.find_by(name:)
    tag ? tag.albums : []
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
