NotificationType.seed(:name,
  [
      :new_comment_replay,
      :new_work_comment
  ].map { |name| {name: name} }
)
