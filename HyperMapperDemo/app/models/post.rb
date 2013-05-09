class Post
  include HyperMapper::Document
  
  attr_accessor :tag_string
  attr_accessible :title, :content, :user_id, :tag_string
  
  autogenerate_id
  attribute :title
  attribute :content
  attribute :user_id
  
  timestamps

  validates :title, presence: true
  validates :user_id, presence: true
  validates :content, presence: true

  belongs_to :user
  
  # we won't use this yet, but we want to generate this field
  # when we create the new space, so we'll add it now
  embeds_many :comments
  
  has_and_belongs_to_many :tags, through: :post_tags
  
  before_save :update_tags
  
  # and the function to update the tags
  def update_tags
    return unless tag_string
    new_tag_names = tag_string.split(",").map { |t| t.strip.downcase }
    current_tag_names = tags.collect(&:name)
    new_tag_names.each do |tag_name| 
      unless current_tag_names.include? tag_name
        tag = Tag.where(name: tag_name)[0]
        tag = Tag.create! name: tag_name unless tag
        self.tags << tag 
      end
    end
    tags.each { |t| (tags.remove t) unless (new_tag_names.include? t.name) }
  end  
  
  def tags_as_string
  	tags.collect(&:name).join(', ')
  end  
end