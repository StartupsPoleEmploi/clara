class Recall  < ApplicationRecord
  belongs_to :aid, optional: false
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :trigger_at, presence: true
  
  validates :hourmin, presence: true, format: { with: /\A(?!00:00)[0-5][0-9]:[0-5][0-9]\Z/, message: "Entrez un horaire au format hh:mm"}

  scope :not_sent, -> { where(status: 'not_sent') }
  scope :trigger_date_reached, -> { where('trigger_at < ?', DateTime.now) }
  scope :please_send, -> { self.not_sent.merge(self.trigger_date_reached) }
  


end
