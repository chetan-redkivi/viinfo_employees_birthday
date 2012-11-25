class Authentication < ActiveRecord::Base
  attr_accessible :provider, :secret, :token, :uid, :virtue_info_fb_connection_id
  belongs_to :virtue_info_fb_connection
end
