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

end
