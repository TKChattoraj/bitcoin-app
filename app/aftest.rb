class TestLink
  #attr_accessor :address, :user, :password

  def initialize

  end


  def get_link(&callback)
    link = AFHTTPSessionManager.new
    link.GET('https://qrng.anu.edu.au/API/jsonI.php?length=1&type=uint8', parameters: nil, progress: nil,
      success: lambda {|task, response| p response},
      failure: lambda {|task, error| p error.localizedDescription}
    )
    callback.call()
  end


end
