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
  validates :name, presence: true, uniqueness: true

  # scope :by_role,  ->(role) { joins(:roles).where(roles: { name: role }) }
  # scope :without_feed, joins('left outer join authors_feeds on authors.id=authors_feeds.author_id').where('authors_feeds.feed_id is null')
  # scope :without_aid, joins('left outer join aids_filters on filters.id=aids_filters.filter_id').where('aids_filters.aid_id is null')
  
  # scope :not_in_any_group, -> {
  #     joins("LEFT JOIN groups_users ON users.id = groups_users.user_id")
  #     .where("groups_users.user_id IS NULL")
  # }

  scope :not_in_any_group, -> {
    joins("LEFT JOIN aids_filters ON filters.id = aids_filters.filter_id")
    .where("aids_filters.filter_id IS NULL")
  }
  
  scope :with_aid_attached, -> { where.not(id: not_in_any_group) }

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
