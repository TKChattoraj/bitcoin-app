class Bitcoin
  attr_accessor :address, :user, :password

  def initialize
    #@address = "http://127.0.0.1:8332"
    @address = "http://127.0.0.1:8332"
    @user = "Witcohe13"
    @password = "1Btdwafvacu3"
  end


  def get_info(&callback)
    credentials = {username: @user, password: @password}
    data = {"method" => "getinfo", "params" => [], "id" => "jsonrpc"}
    options = { payload: data, credentials: credentials, format: :json}
    BubbleWrap::HTTP.post(@address, options) do |response|
      if response.ok?
        response_body = BubbleWrap::JSON.parse(response.body.to_str)
      elsif response.status_code.to_s =~ /40\d/
        alert = NSAlert.alloc.init
        alert.setMessageText "Login Failed"
        alert.addButtonWithTitle "OK"
        alert.runModal
      else
        alert = NSAlert.alloc.init
        alert.setMessageText response.error_message
        alert.addButtonWithTitle "OK"
        alert.runModal
      end
      callback.call(response_body["result"])
    end
  end

  def get_raw_transaction(transaction_id, &callback)
    credentials = {username: @user, password: @password}
    #txid = "0627052b6f28912f2703066a912ea577f2ce4da4caa5a5fbd8a57286c345c2f2"
    txid = transaction_id
    verbose = 0
    args = [txid, verbose]
    data = {"method" => "getrawtransaction", "params" => args, "id" => "jsonrpc"}
    options = { payload: data, credentials: credentials, format: :json}

    BubbleWrap::HTTP.post(@address, options) do |response|
      if response.ok?
        response_body = BubbleWrap::JSON.parse(response.body.to_str)
      elsif response.status_code.to_s =~ /40\d/
        alert = NSAlert.alloc.init
        alert.setMessageText "Login Failed"
        alert.addButtonWithTitle "OK"
        alert.runModal
      else
        alert = NSAlert.alloc.init
        alert.setMessageText response.error_message
        alert.addButtonWithTitle "OK"
        alert.runModal
      end
      callback.call(response_body["result"])
    end
  end

  def decode_raw_transaction(&callback)
    credentials = {username: @user, password: @password}
    txid = "0627052b6f28912f2703066a912ea577f2ce4da4caa5a5fbd8a57286c345c2f2"
    verbose = 0
    args = [txid, verbose]
    data = {"method" => "getrawtransaction", "params" => args, "id" => "jsonrpc"}
    options = { payload: data, credentials: credentials, format: :json}
    #BubbleWrap::HTTP.post(@address, {credentials: credentials, payload: data}) do |response|
    BubbleWrap::HTTP.post(@address, options) do |response|
      if response.ok?
        response_body = BubbleWrap::JSON.parse(response.body.to_str)
      elsif response.status_code.to_s =~ /40\d/
        alert = NSAlert.alloc.init
        alert.setMessageText "Login Failed"
        alert.addButtonWithTitle "OK"
        alert.runModal
      else
        alert = NSAlert.alloc.init
        alert.setMessageText response.error_message
        alert.addButtonWithTitle "OK"
        alert.runModal
      end
      #callback.call(response_body["result"])
    #end
      args = [response_body["result"]]
      data = {"method" => "decoderawtransaction", "params" => args, "id" => "jsonrpc"}
      options = { payload: data, credentials: credentials, format: :json}
      #BubbleWrap::HTTP.post(@address, {credentials: credentials, payload: data}) do |response|
      BubbleWrap::HTTP.post(@address, options) do |response|
        if response.ok?
          response_body = BubbleWrap::JSON.parse(response.body.to_str)
        elsif response.status_code.to_s =~ /40\d/
          alert = NSAlert.alloc.init
          alert.setMessageText "Login Failed"
          alert.addButtonWithTitle "OK"
          alert.runModal
        else
          alert = NSAlert.alloc.init
          alert.setMessageText response.error_message
          alert.addButtonWithTitle "OK"
          alert.runModal
        end
        callback.call(response_body["result"]["txid"])
      end
    end

  end

end
