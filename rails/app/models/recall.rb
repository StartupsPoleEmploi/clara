class Recall  < ApplicationRecord
  belongs_to :aid, optional: false
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :trigger_at, presence: true

  before_save :default_values

  scope :not_sent, -> { where(status: 'not_sent') }
  scope :trigger_date_reached, -> { where('trigger_at < ?', DateTime.now) }
  scope :please_send, -> { self.not_sent.merge(self.trigger_date_reached) }
  
  def default_values
    self.trigger_at = self.trigger_at.change({ hour: 7, min: 30, sec: 0 })
  end


end
