class Requester
  def get(url)
    url = url.gsub(/[^\u0020-\u007E]/, '') # remove hidden chars
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    request = build_get_request(uri)
    http.request(request)
  end

  private

  def build_get_request(uri)
    request = Net::HTTP::Get.new(uri.to_s)
    request['User-Agent'] = 'Cache Warmer 1.0'
    request['accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9'
    request['accept-encoding'] = 'gzip, deflate, sdch'
    request['accept-language'] =  'en-US'

    request
  end
end
