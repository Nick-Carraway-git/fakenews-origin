class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :user_boardrooms
  has_many :boardrooms, through: :user_boardrooms
  has_many :chats
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :favoring, through: :favorites, source: :article

  has_one_attached :image
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

  # フォロー関係のメソッド
  # ユーザーをフォローする
  def follow(other_user)
    # unless self == other_user
      following << other_user
    # end
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 投稿をいいねする
  def favor(favorite_article)
    favoring << favorite_article
  end

  # いいねを解除する
  def unfavor(favorite_article)
    self.favorites.find_by(article_id: favorite_article.id).destroy
  end

  # お気に入り済みならtrueを返す
  def favoring?(favorite_article_id)
    nowFavorite = Favorite.find_by(article_id: favorite_article_id)
    if nowFavorite != nil
      return nowFavorite[:user_id] == self.id
    end
  end
end
