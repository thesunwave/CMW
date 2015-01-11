shared_examples 'needs authentication' do |example_title, method, path, payload = {}|

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
    expect(json.keys.count).to eq(1)
    expect(json['error_key']).to eq('unauthenticated')
    expect(response).to have_http_status(:unauthorized)
  end

end