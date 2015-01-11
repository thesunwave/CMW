# 
# Файл содержит данные, добавляемые в БД при развёртывании проекта
#

# 
# Создаем роли
# 
puts "CREATE ROLES"
roles = %w(
  user
  director
  admin
)
roles.each do |role|
  r = Role.find_or_create_by(name: role)
  puts 'role: ' + r.name.to_s + ' [' + r.id.to_s + ']'
end

# 
# Создаем типы уведомлений
# 
puts "\nCREATE NOTIFICATION TYPES"
notification_types = %w(
  new_comment_replay
  new_work_comment
)
notification_types.each do |row|
  n = NotificationType.find_or_create_by name: row
  puts 'notification: ' + n.name.to_s + ' [' + n.id.to_s + ']'
end
# Заполняем массив уведомлений по умолчанию
puts "\nSEED DEFAULT NOTIFICATIONS"
default_notifications = {
    user: [:new_comment_replay]
}

default_notifications.each do |role_name, n_names|
  role = Role.find_by_name role_name

  next unless role

  n_names.each do |n_name|
    n_type = NotificationType.find_by_name n_name

    next unless n_type

    role.default_notifications << n_type unless role.default_notifications.exists? n_type
  end
end
