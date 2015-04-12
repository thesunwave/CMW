class User < ActiveRecord::Base

  #
  # Роли
  #
  # :guset
  # :user
  # :director
  # :admin

  # rolify after_add: :assign_default_notifications_for
  # after_create :assign_default_role, :assign_default_notifications, :assign_default_username

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  # devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  #Удаляем перед валидацией пробелы с начала и конца имени и фамилии
  before_validation :trim

  #
  # Связи
  #
  belongs_to  :avatar, dependent: :destroy
  has_many    :works, dependent: :destroy
  #has_many    :images, through: :image_file
  has_many    :notifications, dependent: :destroy
  has_many    :notification_types, through: :notifications


  #
  # Валидации полей
  #
  # почта проверяется на валидность в модели Devise
  validates_format_of  :email, presence: true,
                    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                    message: I18n.t('errors.messages.invalid')

  # соглашение с условиями
  validates :terms_of_service, acceptance: true

  # пароли проверяются на валидность в модели Devise
  validates_confirmation_of :password

  #
  # Имя
  #
  validates :first_name, presence: true, length: { maximum: 30 },
          format: { with: /\A[\p{L}]*\Z/i, message: I18n.t('errors.messages.invalid') }

  #
  # Фамилия
  #
  validates :last_name, presence: true, length: { maximum: 40 },
          format: { with: /\A[\p{L}]*\Z/i, message: I18n.t('errors.messages.invalid') }

  #
  # Язык
  #
  validates_presence_of :lang, inclusion: {
    in: I18n.available_locales.collect { |l| l.to_s },
    message: I18n.t('errors.messages.invalid')
  }

  #
  # url (username)
  #
  validates_length_of :username, in: 3...25
  validate  :validate_username


  #
  # Public методы
  #

  # вычисляемое свойство name
  def name
    if first_name.present? || last_name.present?
      space = (first_name.present? && last_name.present?) ? ' ' : ''
      first_name + space + last_name
    else
      id_to_s
    end
  end

  # возвращает роль с наивысшим приорететом
  def role
    I18n.t('role.' + Role.find(roles.maximum("id")).name.to_s)
  end

  # возвращает расширенный объект настроек пользователя
  def get_settings
    # получаем данные, исключаем ненужные поля
    settings = self.as_json(except: [:created_at, :updated_at])
    # добавить уведомления
    user_notifications = []
    self.notification_types.each { |n| user_notifications.push(n.name) } unless self.notification_types.nil?
    settings.merge!({ notifications: user_notifications })
  end

  # добавить уведомление
  def add_notification(name)
    notification_type = NotificationType.find_by_name(name)
    if notification_type
      self.notification_types << notification_type
    end
  end
  # удалить уведомление
  def remove_notification(name)
    notification_type = NotificationType.find_by_name(name)
    if notification_type
      self.notification_types.delete notification_type
    end
  end

  # проверить, подписан ли пользователь на определенный тип уведомлений
  def has_notification?(name)
    return false if self.notifications.empty?

    notification = NotificationType.find_by_name name
    return false if notification.nil?

    self.notification_types.exists? notification.id
  end

  # Валидация поля username
  # метод класса, вынесен в public, так как используется в:
  #     common api -> check_username
  # в объекте instance передается экземпляр объекта, для которого вызывается валидация
  # если instance пуст, функция возвращает булево утверждение относительно валидности поля username
  def self.valid_username?(username, instance = nil)
    unless username.blank?
      # проверяет на валидность имя пользователя
      unless (username =~ /\A[a-z0-9][-a-z0-9]{2,24}\z/i)
        instance.errors.add(:username, I18n.t('errors.messages.invalid')) and return unless instance.nil?
        return false if instance.nil?
      end

      # проверяет на наличие в black-листе
      wrong_names = ['admin','administartion','administrator','help','adm','cmwsu','cmw.su','cmw_su','cmw-su','cmw']
      if wrong_names.include?(username)
        instance.errors.add(:username, I18n.t('errors.messages.already_in_use')) and return unless instance.nil?
        return false if instance.nil?
      end

      # проверяет на уникальность сохраняемое имя пользователя
      if exist = User.find_by_username(username)
        unless instance.nil?
          if exist.id != instance.id
            instance.errors.add(:username, I18n.t('errors.messages.already_in_use')) and return
          end
        else
          return false
        end
      end
    end
    return true if instance.nil?
  end


private

  def trim
    self.first_name.strip!
    self.last_name.strip!
  end

  #
  # Присвоения по умолчанию после создания объекта
  #

  # Присвоить роль по умолчанию
  def assign_default_role
    add_role :user
  end

  # Присвоить уведомления по умолчанию
  def assign_default_notifications
    roles.each do |role|
      assign_default_notifications_for role
    end
  end

  # Присвоить уведомления по умолчанию согласно роли
  def assign_default_notifications_for(role)
    self.notification_types += role.default_notifications
  end

  # Возвращает имя пользователя
  def assign_default_username
    self.username = id_to_s if read_attribute(:username).blank?
  end

  # Преобразовать идентификатор в строку
  def id_to_s
    "id#{id.to_s}" if self.persisted?
  end


  #
  # Валидация имени пользователя
  #
  def validate_username
    unless self.username.blank?
      # перевести username в нижний регистр
      self.username.downcase!
      User.valid_username?(self.username, self)
    end
  end

end   # class User
