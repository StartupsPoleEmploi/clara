# == Schema Information
#
# Table name: filters
#
#  id          :integer(8)      not null, primary key
#  name        :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :string
#  slug        :string
#
require "image_processing/mini_magick"
class Filter < ApplicationRecord
  extend FriendlyId

  after_save    { ExpireCacheJob.perform_later } if Rails.env.production?
  after_update  { ExpireCacheJob.perform_later } if Rails.env.production?
  after_destroy { ExpireCacheJob.perform_later } if Rails.env.production?
  after_create  { ExpireCacheJob.perform_later } if Rails.env.production?

  # validates :attachment, content_type: { in: ['image/jpg', 'image/jpeg'], message: 'le fichier choisi n\'est pas une image JPG' }, if: :has_attachment?
  # validates :attachment, size: { less_than: 50.kilobytes , message: 'taille de la photo : 50 Ko maximum' }, if: :has_attachment?
  # validates :attachment, dimension: { width: 240, height: 240 , message: 'les dimensions autorisées sont 240x240' }, if: :has_attachment?
  

  # has_one_attached :attachment



  has_attached_file :illustration

  has_and_belongs_to_many :aids

  scope :homable, -> { where.not(illustration_file_name: '') }
  scope :without_aid_attached, -> {
    joins("LEFT JOIN aids_filters ON filters.id = aids_filters.filter_id")
    .where("aids_filters.filter_id IS NULL")
  }
  
  scope :with_aid_attached, -> { where.not(id: without_aid_attached) }


  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  # validates_with AttachmentPresenceValidator, attributes: :illustration
  validates_with AttachmentSizeValidator, attributes: :illustration, less_than: 50.kilobytes, message: 'taille de 50 Ko maximum'
  validates_attachment_content_type :illustration, :content_type => ["image/jpg", "image/jpeg"], message: 'seules les images JPG sont autorisées'
  validates_attachment :illustration, dimensions: { height: 240, width: 240 }
  validates :author, presence: true, if: :has_illustration?

  def has_illustration?
    !!illustration_file_name
  end


  def should_generate_new_friendly_id?
    slug.blank?
  end

end
