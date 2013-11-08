class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLES = %w[admin gather edit data_manager]

  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  field :role, type: String , default: ''


  def self.from_omniauth(auth)
    #create_with_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]

    end
  end

end
