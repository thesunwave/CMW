module FavoriteWorksHelper

  def add_to_favs(work)
    unless current_user.favorite_works.exists?(id: work.id)
      link_to "В избранное!", favorite_works_path(username: work.user.username ,work_id: work.id),
      method: :post
    else
      link_to 'Удалить из избранного', favorite_works_path(username: work.user.username ,work_id: work.id),
      method: :delete
    end
  end
end
