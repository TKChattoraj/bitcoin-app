

class AppDelegate

  TOOLBAR_IDENTIFIER = "AppToolbar"
  INCREMENT_TOOLBAR_ITEM_IDENTIFIER = "IncrementToolbarItem"



  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
    get_info
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [960, 720]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
    @mainWindow.delegate = self

    size = @mainWindow.frame.size

    @toolbar = NSToolbar.alloc.initWithIdentifier(TOOLBAR_IDENTIFIER)
    @toolbar.displayMode = NSToolbarDisplayModeLabelOnly
    @toolbar.delegate = self
    @mainWindow.setToolbar(@toolbar)


    @layout = MainLayout.new
    @mainWindow.contentView = @layout.view


    @transaction_id = @layout.get(:transaction_id).stringValue
    @raw_tx_button = @layout.get(:get_raw_tx_button)
    @raw_tx_button.target = self
    @raw_tx_button.action = 'get_raw_transaction:'
    @raw_transaction = @layout.get(:raw_transaction)

    @keys_button = @layout.get(:keys_button)
    @keys_button.target = self
    @keys_button.action = 'get_keys'

    @private_key_result = @layout.get(:private_key_result)
    @public_key_result = @layout.get(:public_key_result)

    @uncompressed_public_key_result = @layout.get(:uncompressed_public_key_result)
    @compressed_public_key_result = @layout.get(:compressed_public_key_result)

    @public_key_hash_result = @layout.get(:public_key_hash_result)
    @public_key_address_result = @layout.get(:public_key_address_result)


    #get view elements for the coinbase transaction
    @trigger_transaction = @layout.get(:transaction_button)
    @trigger_transaction.target = self
    @trigger_transaction.action ='build_tx'

    @txo_pay_result = @layout.get(:txo_pay_result)
    @txo_change_result = @layout.get(:txo_change_result)
    @txin_result = @layout.get(:txin_result)

    @txid_result = @layout.get(:txid_result)
    @tx_payload_result = @layout.get(:tx_payload_result)

    #get view elements for the spending the coinbase transaction

    @trigger2_transaction = @layout.get(:transaction2_button)
    @trigger2_transaction.target = self
    @trigger2_transaction.action ='build2_tx'

    @txo2_pay_result = @layout.get(:txo2_pay_result)
    @txo2_change_result = @layout.get(:txo2_change_result)
    @txin2_result = @layout.get(:txin2_result)

    @txid2_result = @layout.get(:txid2_result)
    @tx2_payload_result = @layout.get(:tx2_payload_result)







  end

  def get_keys
        # @privateKey = BTCRandomDataWithLength(32)
        # @hexPrivateKey = BTCHexFromData(@privateKey)
        # puts "private key: "
        # puts @hexPrivateKey
        # @private_key_result.stringValue = @hexPrivateKey


        @key = BTCKey.alloc.init
        @key_public = @key.publicKey
        @key_public_hex = BTCHexFromData(@key_public)
        @key_private = @key.privateKey
        @key_private_hex = BTCHexFromData(@key_private)


        @uncompressed_public_key = @key.uncompressedPublicKey
        @uncompressed_public_key_hex = BTCHexFromData(@uncompressed_public_key)

        @compressed_public_key = @key.compressedPublicKey
        @compressed_public_key_hex = BTCHexFromData(@compressed_public_key)

        #put the values in the view:

        @private_key_result.stringValue = @key_private_hex
        @public_key_result.stringValue = @key_public_hex
        @uncompressed_public_key_result.stringValue = @uncompressed_public_key_hex
        @compressed_public_key_result.stringValue = @compressed_public_key_hex

        @key2 = BTCKey.alloc.initWithPrivateKey(@key_private)
        @key2_public = @key2.publicKey
        @key2_public_hex = BTCHexFromData(@key2_public)
        puts "Public Key 2:"
        puts @key2_public_hex

        #Public Key Hash.  Line 558 BTCKey.m.  Returns a BTCPublicKeyAddress object
        @public_key_hash_uncompressed = @key.uncompressedPublicKeyAddress

        #make a hex representation of the PublicKeyAddress without version '00' or checksum
        #take as input to BTCHexFromData the NSData object of the BTCPublicKeyAddress object.
        @public_key_hash_uncompressed_hex = BTCHexFromData(@public_key_hash_uncompressed.data)

        #make a hex representation of the PublicKeyAddress with version '00' and checksum
        #@public_key_hash_uncompressed_version_check_hex = BTCHexFromData(@public_key_hash_uncompressed.publicAddress)

        #Sending the uncompressed public key hash to the view
        #This is the just the payload--it doesn't show the Version '00' or the Checksum
        @public_key_hash_result.stringValue = @public_key_hash_uncompressed_hex

        puts "Uncompressed Public Key Address"
        puts @public_key_hash_uncompressed_hex

        #Base58Encoding.
        @public_key_base58 = @public_key_hash_uncompressed.string

        @public_key_address_result.stringValue = @public_key_base58
        puts "Base 58"
        puts @public_key_base58
        puts "end base 58"

        puts "Public Key with version '00' and checksum"
        puts @public_key_hash_uncompressed.publicAddress


        puts "Public Key:"
        puts @key_public_hex
        puts "Private Key:"
        puts @key_private_hex

        puts "Class"
        puts @public_key_hash_uncompressed.class


        #create a PublicKeyAddress from the string of an Address in Base 58
        #@public_key_2_base58_string = @public_key_base58
        @public_key_2_base58_string = "14BPqU9CdRGYrTf6mREDTvLnafPE3yUT8Y"
        @public_key_2_from_base58 = BTCDataFromBase58CString(@public_key_2_base58_string)
        @public_from_base58_hash_data = @public_key_2_from_base58
        puts "Public Key 2 Hash from Base 58:"
        puts BTCHexFromData(@public_from_base58_hash_data)
        puts "end Public Key 2 from Base 58"
        @public_key_2_base58 = BTCAddress.addressWithString(@public_key_2_base58_string)
        puts "Public Key 2 class:"
        puts @public_key_2_base58.class
        puts "Public Key 2 Hash:"
        puts BTCHexFromData(@public_key_2_base58.data)
        puts "end Public Key 2"

        #create a PrivateKeyAddress from the WIF of a private key"
        @private_key_2_base58_string = "KyTeyGJiG2e7ToXmcD1B6tMWgfDd3F1CMvBbSp65rzL4XjsRpcZo"
        @private_key_2 = BTCAddress.addressWithString(@private_key_2_base58_string)
        @private_key_2_hex = BTCHexFromData(@private_key_2.data)

        puts "Private Key 2 class:"
        puts @private_key_2.class
        puts "End Private Key 2 class"

        puts "Private Key 2 0x"
        puts @private_key_2_hex
        puts "end Private Key 2"

        @key_2_derrived = get_public_key(@private_key_2.data)

        #make the derived public key a public key hash
        @public_key_2_derrived_hash = @key_2_derrived.compressedPublicKeyAddress
        @public_key_2_derrived_hash_hex = BTCHexFromData(@public_key_2_derrived_hash.data)
        puts "Derrived Public Key Hash"
        puts @public_key_2_derrived_hash_hex
        puts "end public key hash"








        # @transaction_builder = BTCTransactionBuilder.alloc.init
        # @transaction_builder.changeAddress = @public_key_2
        # @changeScript = @transaction_builder.changeScript
        #
        #
        # puts "Transaction Builder:"
        # puts @transaction_builder
        # puts "Change Address:"
        # puts BTCHexFromData(@transaction_builder.changeAddress.data)
        # puts "Should Sign:"
        # puts @transaction_builder.shouldSign
        # puts "Minimum Change:"
        # puts @transaction_builder.minimumChange
        # puts "Change Script:"
        # puts @changeScript.hex
        # puts "Data Source:"
        # puts @transaction_builder.dataSource
        # puts "Unspent Enumerator"
        # puts @transaction_builder.unspentOutputsEnumerator
        # puts "End Transaction Builder"


  end




  # Return a compressed public key
  def get_public_key(private_key)

    key = BTCKey.alloc.initWithPrivateKey(private_key)
    key_from_wif = BTCKey.alloc.initWithWIF(@private_key_2_base58_string)

    puts "Key from WIF public address then private hex"
    puts key_from_wif.class

    puts BTCHexFromData(key_from_wif.compressedPublicKeyAddress.data)
    puts BTCHexFromData(key_from_wif.privateKey)
    puts "end key form WIF"

    hexPublicKey = BTCHexFromData(key.compressedPublicKey)
    puts "Derived Public Key hex"
    puts hexPublicKey
    puts "end derived Public Key hex--"
    key

    # @publicKeyCompressed = @publicKey.compressedPublicKey
    # @publicKeyUncompressed = @publicKey.uncompressedPublicKey
    #
    #
    #
    # @uncompressed_public_key_result.stringValue = BTCHexFromData(@publicKeyUncompressed)
    # @compressed_public_key_result.stringValue = BTCHexFromData(@publicKeyCompressed)
    #
    # p BTCHexFromData(@publicKeyCompressed)
    # p BTCHexFromData(@publicKeyUncompressed)
    #
    # p @publicKey.uncompressedPublicKeyAddress

  end

  def get_info(*sender)
    @bitcoin = Bitcoin.new
    @balance = @layout.get(:balance)
    @blocks = @layout.get(:blocks)
    NSLog(@bitcoin.address)
    NSLog(@bitcoin.user)
    NSLog(@bitcoin.password)
    response_body = @bitcoin.get_info do |response|
      @balance.stringValue = "$#{response['balance']}"
      @blocks.stringValue = response["blocks"]
    end
  end

  def get_raw_transaction(sender)
    @transaction_id = @layout.get(:transaction_id).stringValue
    @raw_tx_button = @layout.get(:get_raw_tx_button)
    @raw_tx_button.target = self
    @raw_tx_button.action = 'get_raw_transaction:'
    @raw_transaction = @layout.get(:raw_transaction)

    @bitcoin = Bitcoin.new

    NSLog(@bitcoin.address)
    NSLog(@bitcoin.user)
    NSLog(@bitcoin.password)
    response_body = @bitcoin.get_raw_transaction(@transaction_id) do |response|
      @raw_transaction.stringValue = response
    end
  end

  def decode_raw_transaction(sender)
    @bitcoin = Bitcoin.new
    NSLog(@bitcoin.address)
    NSLog(@bitcoin.user)
    NSLog(@bitcoin.password)
    response_body = @bitcoin.decode_raw_transaction do |response|
      @get_tx_3_result.stringValue = response
    end
  end


  def get_transaction(sender)
    @get_tx_result.stringValue = "Result is here!"
  end

  def toolbarAllowedItemIdentifiers(toolbar)
    [NSToolbarShowColorsItemIdentifier, INCREMENT_TOOLBAR_ITEM_IDENTIFIER]
  end

  def toolbarDefaultItemIdentifiers(toolbar)
    [NSToolbarShowColorsItemIdentifier, INCREMENT_TOOLBAR_ITEM_IDENTIFIER]
  end

  def toolbar(toolbar, itemForItemIdentifier: identifier, willBeInsertedIntoToolbar: flag)
    if identifier == INCREMENT_TOOLBAR_ITEM_IDENTIFIER
      item = NSToolbarItem.alloc.initWithItemIdentifier(INCREMENT_TOOLBAR_ITEM_IDENTIFIER)
      item.label = "Increment"
      item.toolTip = "Increment our content view counter."
      item.target = self
      item.action = 'increment:'
      item
    else
      nil
    end
  end

  def increment(toolbar)
    @content_counter ||= 0
    @content_counter += 1
    @content_heading.stringValue = "#{@content_counter} times"
  end

  def redraw_gradients
    @content_tabs.tabViewItems.each {|item| item.view.subviews[0].needsDisplay = true}
  end

end
