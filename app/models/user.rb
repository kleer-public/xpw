class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :crypted_password, String
  property :email, String
  has n, :job_offers

  validates_presence_of :name
  validates_presence_of :crypted_password
  validates_presence_of :email
  validates_format_of   :email,    :with => :email_address

  def password= (password)
    password = nil if password.length < 8
    password = nil if ! /[0-9]+/.match(password)
    password = nil if ! /[A-Z]+/.match(password)
    password = nil if ! /[a-z]+/.match(password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?
    self.crypted_password = nil if password.nil?
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.has_password?(password)? user : nil
  end

  def has_password?(password)
    return false if crypted_password.nil?
    ::BCrypt::Password.new(crypted_password) == password
  end

end
