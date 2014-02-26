class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLES = %w[admin data_gather data_editor data_manager]

  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  field :role, type: String , default: ''
  field :last_login_ip, type: String 

  has_many :categories
  has_many :csvfiles
  has_many :pairs
  has_many :products
  has_many :properties
  has_many :events
  has_many :resources

  has_and_belongs_to_many :permissions

  

  def self.from_omniauth(auth)
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

  def has_role?(role)
    case role
    when :admin then admin?
    when :data_gather then data_gather?
    when :data_editor then data_editor?
    when :data_manager then data_manager?
    else false
    end
  end
  def admin?
    self.role.eql?("admin")
  end
  def data_manager?
    self.role.eql?("data_manager")
  end

  def data_gather?
    self.data_manager? or self.role.eql?("data_gather")
  end
  def data_editor?
    self.data_manager? or self.role.eql?("data_editor")
  end

end
