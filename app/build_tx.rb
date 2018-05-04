def build_tx

  #initialize the transaction
  transaction = BTCTransaction.alloc.init

  #create a pay address:
  #create a private/public key pair
  pay_key = BTCKey.alloc.init
  public_pay_address = pay_key.compressedPublicKeyAddress

  #create a transaction output for the pay address:
  pay_satoshis = 31
  tx_o_pay = BTCTransactionOutput.alloc.initWithValue(pay_satoshis, address: public_pay_address)

  #add transaciton output to the transaction
  transaction.addOutput(tx_o_pay)

  #update the view:
  @txo_pay_result.stringValue = BTCHexFromData(tx_o_pay.data)

  # #designate fee amount
  # fee_satoshis = 3
  #
  # #create a change address:
  # change_key = BTCKey.alloc.init
  # public_change_address = change_key.compressedPublicKeyAddress
  #
  # #change amount:
  # change_satoshis = pay_satoshis - fee_satoshis
  #
  # #create a transaction output for the change address:
  # tx_o_change = BTCTransactionOutput.alloc.initWithValue(change_satoshis, address: public_change_address)
  #
  # #add transaction output to the transaction
  # transaction.addOutput(tx_o_change)
  #
  # #update the view:
  # @txo_change_result.stringValue = BTCHexFromData(tx_o_change.data)


  #Create the input for the coinbase transaction
  #Create a dictionary hash
  dictionary = {}
  #Make this as a coinbase -- "hash" = 32 byte 0 hash, "index" = ffffffff in hex
  prev_out = {"hash" => "0000000000000000000000000000000000000000000000000000000000000000", "n" => 4294967295}
  dictionary["prev_out"] = prev_out
  #make the coinbase data one byte of number 13-- 0x 01 0d
  hex_string = "010d"

  coinbase_data = BTCDataFromHex(hex_string)
  coinbase_hex = BTCHexFromData(coinbase_data)
  dictionary["coinbase"] = coinbase_hex

  #Create the transaction input:
  tx_in = BTCTransactionInput.alloc.initWithDictionary(dictionary)

  #add transaction input to the transaction:
  transaction.addInput(tx_in)

  #update the view:

  @txin_result.stringValue = BTCHexFromData(tx_in.data)
  @txid_result.stringValue = transaction.transactionID
  @tx_payload_result.stringValue = transaction.hex #gives the tx payload in hex

  @coinbase_transaction = transaction
  parsed_transaction = BTCTransaction.alloc.initWithHex(@coinbase_transaction.hex)
  puts "Coinbase parsed"
  puts parsed_transaction.dictionary
  puts "End Coinbase parse"
end



def build2_tx

  #initialize the transaction
  transaction = BTCTransaction.alloc.init

  #create a pay address:
  #create a private/public key pair
  pay_key = BTCKey.alloc.init
  public_pay_address = pay_key.compressedPublicKeyAddress

  #create a transaction output for the pay address:
  pay_satoshis = 21
  tx_o_pay = BTCTransactionOutput.alloc.initWithValue(pay_satoshis, address: public_pay_address)

  #add transaciton output to the transaction
  transaction.addOutput(tx_o_pay)

  #update the view:
  @txo2_pay_result.stringValue = BTCHexFromData(tx_o_pay.data)

  #designate fee amount
  fee_satoshis = 3

  #create a change address:
  change_key = BTCKey.alloc.init
  public_change_address = change_key.compressedPublicKeyAddress

  #change amount:
  change_satoshis = pay_satoshis - fee_satoshis

  #create a transaction output for the change address:
  tx_o_change = BTCTransactionOutput.alloc.initWithValue(change_satoshis, address: public_change_address)

  #add transaction output to the transaction
  transaction.addOutput(tx_o_change)

  #update the view:
  @txo2_change_result.stringValue = BTCHexFromData(tx_o_change.data)


  #Create the input for the coinbase transaction

  dictionary = {}
  #Create dictionary for input
  prev_out = {"hash" => @coinbase_transaction.transactionID, "n" => 1}
  dictionary["prev_out"] = prev_out


  #Create the transaction input:
  tx_in = BTCTransactionInput.alloc.initWithDictionary(dictionary)
  puts "Coinbase?"
  puts tx_in.isCoinbase
  puts "End coinbase"
  puts "tx 2 input"
  puts BTCHexFromData(tx_in.data)
  puts "end tx 2 input"

  #add transaction input to the transaction:
  transaction.addInput(tx_in)

  #update the view:

  @txin2_result.stringValue = BTCHexFromData(tx_in.data)
  @txid2_result.stringValue = transaction.transactionID
  @tx2_payload_result.stringValue = transaction.hex #gives the tx payload in hex


  parsed_transaction = BTCTransaction.alloc.initWithHex(transaction.hex)
  puts "Trans 2 parsed"
  puts parsed_transaction.dictionary
  puts "End Trans 2 parse"


end
