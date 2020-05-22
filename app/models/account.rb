class Account < ApplicationRecord
  before_create :generate_token

  ROLE = {0 => "user",1 => "admininstrator",2 => "superadmin"}
  def generate_token
    auth_token = nil
    begin
      auth_token = SecureRandom.urlsafe_base64
      Rails.logger.info "===auth_token==========#{auth_token}"
    end while Account.exists?(auth_token:"#{auth_token}")
    self.auth_token = auth_token
    end

end
