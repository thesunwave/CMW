describe Role do

  before :all do
    SeedFu.quiet = true
    SeedFu.seed SeedFu.fixture_paths, /(roles|notification_types|default_notifications)/
  end

  user: [:new_comment_replay] do |role_name|

    describe role_name do

      let(:role) { Role.find_by_name role_name }

      n_names.map do |n_name|
        it "has default notification :#{n_name}" do
          expect(role.default_notifications).to include(NotificationType.find_by_name n_name)
        end
      end

    end

  end
end
