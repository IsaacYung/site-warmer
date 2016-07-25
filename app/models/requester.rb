class Requester
  DESKTOP = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
  MOBILE = 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1'
  TABLET = 'Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1'

  def get(url, user_agent = Requester::DESKTOP)
    url = url.gsub(/[^\u0020-\u007E]/, '') # remove hidden chars
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    request = build_get_request(uri, user_agent)
    http.request(request)
  end

  private

  def build_get_request(uri, user_agent)
    request = Net::HTTP::Get.new(uri.to_s)
    request['User-Agent'] = user_agent
    request['accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9'
    request['accept-encoding'] = 'gzip, deflate, sdch'
    request['accept-language'] =  'en-US'

    request
  end
end
