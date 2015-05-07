module FavoriteWorksHelper
  def add_to_favs(work)
    unless current_user.nil?
      unless current_user.favorite_works.exists?(id: work.id)
        link_to "В избранное!", favorite_works_path(username: work.user.username ,work_id: work.id),
        method: :post
      else
        link_to 'Удалить из избранного', favorite_work_path(id: work.id, username: work.user.username ,work_id: work.id),
        method: :delete
      end
    else
      link_to 'В избранное', new_user_session_path
    end
  end
end
