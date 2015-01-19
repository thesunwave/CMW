module DeviseHelper
  def devise_error_messages!
    if resource != nil
      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        :count => resource.errors.count,
                        :resource => resource.class.model_name.human.downcase)

      html = <<-HTML
        <div class="alert warning"><div class="message">#{sentence}. #{messages}</div><div class="close"></div></div>
      HTML

      html.html_safe
    else
      return ""
    end
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end