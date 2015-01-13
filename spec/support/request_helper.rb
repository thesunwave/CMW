module Requests  
  module Helpers
    def t(str, locals = nil)
      I18n.t(str, locals)
    end
  end   # Helpers

  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end
  end   # JsonHelpers
end   # Requests

RSpec.configure do |config|
  config.include Requests::Helpers
  config.include Requests::JsonHelpers, type: :request
  config.include Requests::JsonHelpers, type: :controller
end

# FormatMatcher added to easyer format check:
#   json = { id: 1, email: here }
#   expect(json).to match_format("id", "email")
#   should pass
RSpec::Matchers.define :match_format do |*expected_format|
    require 'set'
    # если в качестве аргумента массив, нормализуем аргумент
    expected_format = expected_format[0] if expected_format[0].is_a? Array
    # сравниваем наличие ключей json с эталоном
    match do |json_resource|
        json_resource.keys.to_set == expected_format.to_set
    end
end
