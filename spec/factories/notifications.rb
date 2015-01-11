FactoryGirl.define do

  factory :notification_type do
    name
  end

  notification_types = %w(
    new_comment_replay
    new_work_comment
  )

  sequence :name do |n|
    if n.between? 0, notification_types.size-1
      notification_types[n-1] 
    else
      "notification_#{n}"
    end
  end

end
