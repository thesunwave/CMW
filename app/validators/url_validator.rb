require 'uri'

class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if record.present?
      unless value.blank?
        url = URI(value)
        if url.host.present?
          return
        else
          record.errors.add(attribute, options[:message])
        end
      else
        return
      end
    end
  end
end