shared_examples 'user settings' do |example_title, method, path, payload = {}|

  it "#{example_title}" do
    if method == :get
      get path, payload
    elsif method == :post
      post path, payload
    elsif method == :patch
      patch path, payload
    elsif method == :delete
      delete path, payload
    end
    expect(json['user']).to match_format(user.as_json.except('created_at', 'updated_at').keys.push('country_id', 'notifications'))
    expect(response).to have_http_status(:ok)
  end

end