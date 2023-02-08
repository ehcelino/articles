class User < ApplicationRecord
  before_create { generate_token(:auth_token) }
  has_secure_password validations: false
  # attr_accessor :username, :email, :password, :password_confirmation
  has_many :articles
  has_many :comments

  validates_uniqueness_of :username
  validates :username, presence: {message: "não pode estar em branco."}, length: { in: 4..14, message: 'tem que ter entre 4 a 14 caracteres.' }, uniqueness: {message: 'já em uso.'}, blacklist: true, username: true
  validates :email, presence: {message: "não pode estar em branco."}, uniqueness: {message: 'já em uso.'}
  validates :password, presence: {message: "não pode estar em branco."}, length: { in: 3..6, message: 'tem que ter entre 3 a 6 caracteres.' }

  HUMANIZED_ATTRIBUTES = {
  :email => "Email",
  :password => "Senha", 
  :username => "Usuário",
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
