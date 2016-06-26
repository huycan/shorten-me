class HttpRequestSerializerService
  def serialize request
    { 
      headers: headers(request) 
    }
  end

  def headers request
    # reference
    # http://stackoverflow.com/questions/28687674/how-to-log-an-entire-request-headers-body-etc-for-a-certain-url
    http_envs = {}.tap do |envs|
      request.headers.each do |key, value|
        envs[key] = value if key.downcase.starts_with?('http')
      end
    end

    http_envs
  end
end