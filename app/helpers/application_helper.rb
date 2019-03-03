module ApplicationHelper
	def user_avatar(user)
		if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'https://panorama.am/news_images/624/1870613_2/86.thumb.jpg'
    end
  end
end
