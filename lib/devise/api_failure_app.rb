class ApiFailureApp < Devise::FailureApp

  def respond
    # устанавливаем заголовки ответа
    self.status = 401
    self.content_type = 'application/json'

    # ошибка по умолчанию
    error_key = :unauthenticated

    # если ключ ошибки warden не пустой, обрабатываем его
    unless warden_message.blank?
      black_list = [:invalid, :not_found_in_database]
      error_key = warden_message unless black_list.include? warden_message
    end

    # вернуть ключ ошибки
    self.response_body = <<-JSON
      { "error_key":"#{error_key.to_s}" }
    JSON
  end

end