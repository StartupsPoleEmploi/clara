class CustomFilter < ApplicationRecord 
  extend FriendlyId

  after_save    { Rails.cache.clear;ActivatedModelsService.instance.regenerate }
  after_update  { Rails.cache.clear;ActivatedModelsService.instance.regenerate }
  after_destroy { Rails.cache.clear;ActivatedModelsService.instance.regenerate }
  after_create  { Rails.cache.clear;ActivatedModelsService.instance.regenerate }

  validates :name, presence: true, uniqueness: true
  friendly_id :name, use: :slugged

  belongs_to :custom_parent_filter
  has_and_belongs_to_many :aids


  def should_generate_new_friendly_id?
    name_changed?
  end

end
