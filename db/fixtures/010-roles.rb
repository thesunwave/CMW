Role.seed(:name,
  [
      :user,
      :director,
      :admin
  ].map { |name| {name: name} }
)
