class Invitation < ActiveRecord::Base
  attr_accessible :recipient_email, :sender_id, :sent_at, :token, :invite_type
  attr_readonly :invite_type, :sender_id, :recipient_email, :token

  belongs_to :sender, class_name: 'User'
  has_one :recipient, class_name: 'User'
  has_one :investor

  validates_presence_of :recipient_email
  validates_presence_of :sender
  validate :recipient_is_not_registered
  validates_inclusion_of :invite_type, :in => [true, false]

  before_create :generate_token

  private

  	def recipient_is_not_registered
  		errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  	end

  	def generate_token
  		self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  	end

    def sender_has_invitations

    end

end