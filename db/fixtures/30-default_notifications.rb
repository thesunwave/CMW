{
	user: [:new_comment_replay]
}.each do |role_name, n_names|
  puts " - Default notifications for role '#{role_name}'" unless SeedFu.quiet
  role = Role.find_by_name role_name

  next unless role

  n_names.each do |n_name|
    n_type = NotificationType.find_by_name n_name

    next unless n_type

    role.default_notifications << n_type unless role.default_notifications.exists? n_type
    puts "     '#{n_name}'" unless SeedFu.quiet
  end
end
