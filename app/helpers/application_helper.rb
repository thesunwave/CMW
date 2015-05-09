module ApplicationHelper
  def current_locale
    current_user && current_user.lang == 'en' ? :en : :ru
  end

  def quote_text(quote)
    field = current_locale == :ru ? :text_rus : :text_eng
    quote[field]
  end

  def quote_author(quote)
    field = current_locale == :ru ? :author_rus : :author_eng
    quote[field]
  end

  def get_user_spec
    unless current_user.nil?
      if current_user.spec.blank?
        link_to 'http://cmw.su/' + "#{current_user.username}", profile_show_path(current_user.username)
      else
        link_to current_user.spec, profile_show_path(current_user.username)
      end
    end
  end

end
