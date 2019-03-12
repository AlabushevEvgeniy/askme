module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'https://panorama.am/news_images/624/1870613_2/86.thumb.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def form_chooser(number, krokodil, krokodila, krokodilov)
    ostatok = number % 10
    ostatok100 = number % 100

    return krokodilov if ostatok100.between?(11, 14)
    return krokodil if ostatok == 1
    return krokodila if ostatok.between?(2, 4)
    return krokodilov if ostatok.between?(5, 9) || ostatok.zero?
  end

end
