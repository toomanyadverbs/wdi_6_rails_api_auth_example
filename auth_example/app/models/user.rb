class User < ActiveRecord::Base
  has_secure_password
  before_create :set_token
  after_find :fix_up_token
  validates :email, uniqueness: true

  def authenticate_with_new_token (password)
    authenticate_without_new_token(password) && new_token
  end

  alias_method_chain :authenticate, :new_token

  private
  def set_token
      #There is a potential bug: there might be a collision of tokens (two Users getting the same randomly generated token number - but the chances are very low and we aren't going to deal with that right now)
  #would just need to add a validation that the token doesn't exist already
    self.token = SecureRandom.hex(16)
  end
  #unconditionally create and set a new token
  def new_token
    update_columns(token: set_token)
  end

#to expire old token:
#could change to last_authenticated < 1.day.ago
  def fix_up_token
    # You wouldn't do this exactly this way in a serious production, because token age should be configurable, and you don't want tokens to remain valid forever
    new_token if updated_at < 1.day.ago
  end
end
