

class BitcoinRPC
  def initialize(service_url)
    @uri = URI.parse(service_url)
    puts @uri.host
    puts @uri.port
    puts @uri.request_uri
    puts @uri.user
    puts @uri.password
  end

  def method_missing(name, *args)
    post_body = { 'method' => name, 'params' => args, 'id' => 'jsonrpc' }.to_json
    resp = JSON.parse(http_post_request(post_body))
    raise JSONRPCError, resp['error'] if resp['error']
    resp['result']
  end

  def http_post_request(name, *args)
    puts args
    post_body = {'method' => name, 'params' => args, 'id' => 'jsonrpc' }.to_json
    puts post_body
    http    = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    request.content_type = 'application/json'
    #request.content_type = 'text/plain'
    request.body = post_body
    response = http.request(request).body
    JSON.parse(response)
  end

  def decoderawtransaction(tx)
    self.http_post_request('decoderawtransaction', tx)
  end


  def getrawtransaction(txid, arg)
    verbose = arg[0]
    self.http_post_request('getrawtransaction', txid, verbose)
  end

  def getinfo()
    self.http_post_request('getinfo')
  end

  class JSONRPCError < RuntimeError; end
end
