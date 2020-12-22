class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # facebook登録・ログインの場合に、適切にユーザー情報を埋めるためのメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      # user.username = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
      # user.image = auth.info.image.gsub("picture","picture?type=large") if user.provider == "facebook"
    end
  end
end
