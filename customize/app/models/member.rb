class Member < ActiveRecord::Base
  attr_accessible :id, :login_id, :password, :name, :tel, :email, :admin, :password_confirmation
  attr_accessor :password, :password_confirmation

  validates :password, presence: { on: :create },
    confirmation: { allow_blank: true}

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
                "%#{query}%", "%#{query}%")
      end
      rel
    end

    def authenticate(name, password)
      member = find_by_name(name)
      if member && member.hashed_password.present? &&
         BCrypt::Password.new(member.hashed_password) == password
        member
      else
        nil
      end
    end
  end
end
