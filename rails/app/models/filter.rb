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
class Filter < ApplicationRecord
  extend FriendlyId

  after_save    { ExpireCacheJob.perform_later } if Rails.env.production?
  after_update  { ExpireCacheJob.perform_later } if Rails.env.production?
  after_destroy { ExpireCacheJob.perform_later } if Rails.env.production?
  after_create  { ExpireCacheJob.perform_later } if Rails.env.production?


  has_and_belongs_to_many :aids

  scope :without_aid_attached, -> {
    joins("LEFT JOIN aids_filters ON filters.id = aids_filters.filter_id")
    .where("aids_filters.filter_id IS NULL")
  }

  scope :with_aid_attached, -> { where.not(id: without_aid_attached) }


  friendly_id :name, use: :slugged

  
  has_one_attached :avatar

  validates :avatar, size: { less_than: 50.kilobytes , message: 'taille de 50 Ko maximum' }
  validates :avatar, content_type: {in: ['image/jpg', 'image/jpeg'], message: 'image jpg seulement'}
  validates :avatar, dimension: {width: 240, height: 240, message: 'Seule les images en 240x240 sont acceptées'}

  validates :name, presence: true, uniqueness: true
  validates :author, presence: true, if: :has_avatar?


  def has_avatar?
    avatar.attached?
  end


  def should_generate_new_friendly_id?
    slug.blank?
  end

end
