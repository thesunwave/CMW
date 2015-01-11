describe 'User:' do

  let (:user) { FactoryGirl.create(:user) }

  it 'Должен создаваться объект с валидными атрибутами' do
    expect(user).to be_valid
  end

  describe 'Почта:' do
    it 'не создается без указания почты' do
      no_email_user = FactoryGirl.build(:user, email: "")
      expect(no_email_user).to be_invalid
    end

    it 'создается с валидной почтой' do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = FactoryGirl.create(:user, email: address)
        expect(valid_email_user).to be_valid
      end
    end

    it 'не создается с невалидной почтой' do
      addresses = %w[mail.com mail@com mail@.com mail @mail.com .com mail@mail,com]
      addresses.each do |address|
        invalid_email_user = FactoryGirl.build(:user, email: address)
        expect(invalid_email_user).to be_invalid
      end
    end

    it 'не создается если почта уже есть в БД' do
      user # call to create object
      user_with_duplicate_email = FactoryGirl.build(:user, email: user.email)
      expect(user_with_duplicate_email).to be_invalid
    end

    it 'не создается при указании почты в верхнем регистре, которая уже есть в БД' do
      upcased_email = 'new_user@example.com'.downcase
      FactoryGirl.create(:user, email: upcased_email)
      user_with_duplicate_email = FactoryGirl.build(:user, email: upcased_email.upcase)
      expect(user_with_duplicate_email).to be_invalid
    end
  end

  describe 'Пароль:' do
    it 'есть атрибут password' do
      expect(user).to respond_to(:password)
    end

    it 'есть атрибут password_confirmation' do
      expect(user).to respond_to(:password_confirmation)
    end
  end

  describe 'Валидации пароля:' do
    it 'не создается без указания пароля' do
      expect(FactoryGirl.build(:user, password: "", password_confirmation: "")).to be_invalid
    end

    it 'не создается при несовпадении или отсутствии поля password_confirmation' do
      expect(FactoryGirl.build(:user, password_confirmation: 'invalid')).to be_invalid
      expect(FactoryGirl.build(:user, password_confirmation: '')).to be_invalid
    end

    it 'не создается без указания пароля длинной менее 5-и символов' do
      short = 'a' * 4
      expect(FactoryGirl.build(:user, password: short, password_confirmation: short)).to be_invalid
    end
  end

  describe 'Шифрование пароля:' do
    it 'есть атрибут encrypted_password' do
      expect(user).to respond_to(:encrypted_password)
    end

    it 'атрибут encrypted_password не пустой' do
      expect(user.encrypted_password).not_to be_blank
    end
  end

  describe 'Роли:' do
    it 'созданный объект имеет роль user' do
      expect(user).to have_role(:user)
    end

    it 'есть атрибут role → атрибут возвращает локализованное название самой высокой по статусу роли' do
      user.add_role :admin
      expect(user.role).to eq(t('role.admin'))
    end
  end

  describe 'Наличие атрибутов:' do
    it 'есть атрибут lang' do
      expect(user).to respond_to(:lang)
    end

    it 'атрибут lang содержит одну из доступных локалей' do
      expect(I18n.available_locales).to include(user.lang.to_sym)
    end

    it 'атрибут encrypted_password не пустой' do
      expect(user.encrypted_password).not_to be_blank
    end

    describe 'Атрибут first_name:' do
      it 'есть атрибут' do
        expect(user).to respond_to(:first_name)
      end

      it 'содержит только русские и латинские буквы' do
        # ошибочные имена
        bad_first_names = ['bad-name', '123-name', '123', '/name', '?name', 'n&ame', 'n*ame', 'name*', '123']
        bad_first_names.each do |bad_name|
          user_with_first_name = FactoryGirl.build(:user, first_name: bad_name)
          user_with_first_name.valid?
          expect(user_with_first_name.errors[:first_name]).to include(t('errors.messages.invalid'))
        end
        # правильные имена
        good_first_names = ['Имя', 'Name']
        good_first_names.each do |good_name|
          user_with_first_name = FactoryGirl.create(:user, first_name: good_name)
          expect(user_with_first_name).to be_valid
        end
      end

      it 'максимальная длинна 30 символов' do
        user_with_first_name = FactoryGirl.build(:user, first_name: 'morethanthirtysymbolsnameherewillbebad')
        expect(user_with_first_name).to be_invalid

        user.update_attributes(first_name: 'morethanthirtysymbolsnameherewillbebad')
        expect(user.errors[:first_name]).to include(t('errors.messages.too_long'))
      end
    end # 'Атрибут first_name:'

    describe 'Атрибут last_name:' do
      it 'есть атрибут' do
        expect(user).to respond_to(:last_name)
      end

      it 'содержит только русские и латинские буквы' do
        # ошибочные имена
        bad_last_names = ['bad-name', '123-name', '123', '/name', '?name', 'n&ame', 'n*ame', 'name*', '123']
        bad_last_names.each do |bad_name|
          user_with_last_name = FactoryGirl.build(:user, last_name: bad_name)
          user_with_last_name.valid?
          expect(user_with_last_name.errors[:last_name]).to include(t('errors.messages.invalid'))
        end
        # правильные имена
        good_last_names = ['Имя', 'Name']
        good_last_names.each do |good_name|
          user_with_last_name = FactoryGirl.create(:user, last_name: good_name)
          expect(user_with_last_name).to be_valid
        end
      end

      it 'максимальная длинна 40 символов' do
        user_with_last_name = FactoryGirl.build(:user, last_name: 'morethanthirtysymbolsnameherewillbebadandwillbeangry')
        expect(user_with_last_name).to be_invalid

        user.update_attributes(last_name: 'morethanthirtysymbolsnameherewillbebadandwillbeangry')
        expect(user.errors[:last_name]).to include(t('errors.messages.too_long'))
      end
    end # 'Атрибут last_name:'

    describe 'Атрибут name:' do
      it 'есть атрибут' do
        expect(user).to respond_to(:name)
      end

      it 'если указаны first_name или last_name → name равен значению одного из них' do
        user_with_name = FactoryGirl.create(:user, first_name: 'Tester', last_name: '')
        expect(user_with_name.name).to eq('Tester')
      end

      it 'если указаны first_name и last_name → name равен first_name + “ “ + last_name' do
        expect(user.name).to eq("#{user.first_name} #{user.last_name}")
      end

      it 'при пустых first_name и last_name → name равен “id” + id.to_s' do
        user_without_name = FactoryGirl.create(:user, first_name: '', last_name: '')
        expect(user_without_name.name).to eq("id#{user_without_name.id}")
      end
    end # 'Атрибут name:'

    describe 'Атрибут username:' do
      it 'есть атрибут' do
        expect(user).to respond_to(:username)
      end

      it "если username не задан, атрибут возвращает 'id' + id.to_s" do
        expect(user.username).to eq("id#{user.id.to_s}")
      end

      it 'при наличии username он возвращается' do
        user_with_username = FactoryGirl.create(:user, username: 'testuser')
        expect(user_with_username.username).to eq("#{user_with_username.username}")
      end

      it 'валидация по black листу'  do
        user.update_attributes(username: 'admin')
        expect(user.errors[:username]).to include(t('errors.messages.already_in_use'))
      end

      it 'синтаксическая валидация' do
        bad_usernames = ['1', '11', '111', '1name', '-name', '+name', '_name', '/name', '/', '/ name', ' /name', ' / name /']
        bad_usernames.each do |name|
          user.update_attributes(username: name)
          expect(user.errors[:username]).to include(t('errors.messages.invalid'))
        end
      end

      it 'username не менее 3 и не более 25 символов' do
        user.update_attributes(username: 'ad')
        expect(user.errors[:username]).to include(t('errors.messages.too_short'))
        user.update_attributes(username: 'adminmustbehereandisthebestnameever')
        expect(user.errors[:username]).to include(t('errors.messages.too_long'))
      end
    end # 'Атрибут username:'

  end   # 'Наличие атрибутов:'

  context 'Уведомления:' do

    let(:n1) { FactoryGirl.create :notification_type }
    let(:n2) { FactoryGirl.create :notification_type }

    describe '#add_notification' do

      it 'добавляет уведомление если такой тип уведомлений существует' do
        user.add_notification n1.name.to_sym
        expect(user.notifications.count).to eq 1
      end

      it 'не добавляет уведомление если такой тип уведомлений не существует' do
        user.add_notification :not_exists_notification
        expect(user.notifications.count).to eq 0
      end

    end

    describe '#remove_notification' do

      it 'удаляет уведомление' do
        user.add_notification n1.name.to_sym
        user.add_notification n2.name.to_sym
 
        user.remove_notification n1.name.to_sym
        expect(user.notifications.count).to eq 1
      end

    end

    describe '#has_notification?' do

      it 'возвращает false если нет ни одного уведомления' do
        expect(user.has_notification? n1.name.to_sym).to be false
      end

      context 'если есть уведомления: ' do

        before :each do
          user.add_notification n1.name.to_sym
        end

        it 'возвращает true если пользователь подписан на данный тип уведомлений' do
          expect(user.has_notification? n1.name.to_sym).to be true
        end

        it 'возвращает false если пользователь не подписан на данный тип уведомлений' do
          expect(user.has_notification? n2.name.to_sym).to be false
        end

      end
    end

    context 'при создании нового пользователя: ' do

      let!(:role) { FactoryGirl.create(:role, default_notifications: [n1, n2]) }

      it 'присваивает уведомления по умолчанию' do
        role.default_notifications.each do |n_type|
          expect(user).to have_notification(n_type.name)
        end
      end

    end

  end

end
