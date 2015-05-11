module FavoriteWorksHelper
  def add_to_favs(work)
    unless current_user.nil?
      unless current_user.favorite_works.exists?(id: work.id)
        link_to "В избранное!", favorite_works_path(username: work.user.username ,work_id: work.id),
        method: :post
      else
        "В избранном <div class=\"b-new__service__item_favourites__remove\">" + link_to('(убрать)', favorite_work_path(id: work.id, username: work.user.username ,work_id: work.id), method: :delete) + "</div>"
      end
    else
      link_to 'В избранное', new_user_session_path
    end
  end
  def check_fav(work)
    unless current_user.nil?
      unless current_user.favorite_works.exists?(id: work.id)
        "b-new__service__item_favourites"
      else
        "b-new__service__item_favourites-added"
      end
    else
      "b-new__service__item_favourites"
    end
  end
end
