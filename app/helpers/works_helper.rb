module WorksHelper

  def delete_work(work)
    unless current_user.nil?
      if current_user.id == work.user.id
      link_to 'Удалить работу', destroy_work_path(username: work.user.username, id: work.id), method: :delete,
      data: { confirm: 'Вы уверены?' }
      end
    end
  end

end
