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

  # validate :attachment_format
  validates :attachment, attached: true, content_type: { in: 'application/pdf', message: 'is not a PDF' }
  has_one_attached :attachment

  def resize_image
    # p '- - - - - - - - - - - - - - attachment_changes- - - - - - - - - - - - - - - -' 
    # ap attachment_changes['attachment'].attachable
    # p ''
    # unless attachment_changes['attachment'].attachable.is_a?(Hash)
    #   resized_image = MiniMagick::Image.read(attachment_changes['attachment'].attachable)
    #   resized_image = resized_image.resize "240x240"
    #   v_filename = attachment.filename
    #   v_content_type = attachment.content_type
    #   attachment.purge
    #   attachment.attach(io: File.open(resized_image.path), filename:  v_filename, content_type: v_content_type)
    # end
  end

  has_and_belongs_to_many :aids
  validates :name, presence: true, uniqueness: true

  scope :without_aid_attached, -> {
    joins("LEFT JOIN aids_filters ON filters.id = aids_filters.filter_id")
    .where("aids_filters.filter_id IS NULL")
  }
  
  scope :with_aid_attached, -> { where.not(id: without_aid_attached) }

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank?
  end

  private

  def attachment_format
   return unless attachment.attached?
   if attachment.blob.content_type.start_with? 'image/'
     if attachment.blob.byte_size > 5.megabytes
       errors.add(:attachment, 'La taille doit être inférieur à 5 Mo')
       attachment.purge
     else
       resize_image
     end
    else
      attachment.purge
      errors.add(:attachment, 'La photo doit être une image JPG')
    end
  end

end
