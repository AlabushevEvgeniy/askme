module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'default_image.jpg'
    end
  end

  def user_header_color(user)
    user.header_color || '#005a55'
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
