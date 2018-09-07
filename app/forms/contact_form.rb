require 'uri'

class ContactForm < ActiveType::Object

  attribute :first_name, :string
  attribute :last_name, :string
  attribute :email, :string
  attribute :region, :string
  attribute :youare, :string
  attribute :askfor, :string
  attribute :question, :string
  attribute :honey, :string

  validates :first_name, presence: { message: "Le prénom est obligatoire" }
  validates :last_name,  presence: { message: "Le nom est obligatoire" }
  validates :email,      presence: { message: "L'email est obligatoire" }
  validates :email,      format: { 
                            with: URI::MailTo::EMAIL_REGEXP, 
                            message: "Un email valide est requis" },  
                            if: Proc.new { |c| c.email.present? }
  validates :region,     presence: { message: "Le choix de la région est obligatoire" }
  validates :youare,     presence: { message: "Cette information est manquante" }
  validates :askfor,     presence: { message: "Une réponse est attendue pour catégoriser votre demande" }
  validates :question,   presence: { message: "Un message est obligatoire pour envoyer votre message" }
  validate :honey_cant_be_filled

  def honey_cant_be_filled
    errors.add(:honey, "can't be filled") if !honey.blank?
  end
  
end
