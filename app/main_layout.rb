class MainLayout < MotionKit::Layout
  SIZE = [150, 30]
  SIDEBAR_WIDTH = 150

  TAB_VIEW_ITEM_IDENTIFIER = "TabViewItem"

  view :txid, :get_tx, :result_lable, :tx

  def layout
    add NSView, :sidebar do
      wantsLayer true
      backgroundColor NSColor.lightGrayColor
      constraints do
        height.equals(:superview)
        width.is SIDEBAR_WIDTH

        min_left.is 0
        min_top.is 0
      end

      add NSTextField, :sidebar_heading do
        bezeled false
        drawsBackground false
        editable false
        selectable false
        stringValue "My Core:"
        constraints do
          width.equals(:superview).minus(20)
          min_left.is 10
          min_top.is 10
        end
      end

      add NSTextField, :balance_heading do
        stringValue "Balance:"
        bezeled false
        drawsBackground false
        editable false
        selectable false
        size_to_fit
        constraints do
          top.equals(:sidebar_heading, :bottom).plus(10)
          left.equals(:sidebar_heading, :left)
        end
      end
      #
      add NSTextField, :balance do
        size_to_fit
        drawsBackground false
        selectable true
        bezeled false
        constraints do
          top.equals(:sidebar_heading, :bottom).plus(10)
          left.equals(:balance_heading, :right).plus(10)
        end
        editable false
      end

      add NSTextField, :blocks_heading do
        stringValue "Blocks:"
        bezeled false
        drawsBackground false
        editable false
        selectable false
        size_to_fit
        constraints do
          top.equals(:balance_heading, :bottom).plus(10)
          left.equals(:sidebar_heading, :left)
        end
      end
      #
      add NSTextField, :blocks do
        size_to_fit
        drawsBackground false
        selectable true
        bezeled false
        constraints do
          top.equals(:balance_heading, :bottom).plus(10)
          left.equals(:blocks_heading, :right).plus(10)
        end
        editable false
      end
    end

    add NSView, :content do
      wantsLayer true
      #backgroundColor NSColor.whiteColor
      constraints do
        height.equals(:superview)
        width.equals(:superview).minus(SIDEBAR_WIDTH)
        left.equals(:sidebar, :right)
        #min_left.is SIDEBAR_WIDTH
        min_top.is 0
      end

      add NSTabView, :content_tabs do

        constraints do
          width.equals(:superview).minus(10)
          height.equals(:superview).minus(10)
        end

        add_tab "TabViewItem_GetRawTx", "Get Raw TX" do
          wantsLayer true

          #backgroundColor colors.delete(colors.shuffle.first)
          constraints do
            left.equals(:superview, :left)
          end

          add GradientView, :gradient_get_raw_tx do
            constraints do
              width.equals(:superview)
              # height.is(30)
              # min_left.is 10
              # min_top.is 10
              #width.equals(:superview)
              height.equals(:superview)
            end

            add NSTextField, :tx_id_label do
              stringValue "Transacion ID:"
              bezeled false
              drawsBackground false
              editable false
              selectable false
              size_to_fit
              constraints do
                top.equals(:gradient_get_raw_tx, :top).plus(10)
                left.equals(:superview, :left).plus(10)
              end
            end

            add NSTextField, :transaction_id do
              stringValue "0627052b6f28912f2703066a912ea577f2ce4da4caa5a5fbd8a57286c345c2f2"
              size_to_fit
              constraints do
                top.equals(:tx_id_label, :bottom).plus(10)
                left.equals(:superview, :left).plus(10)
              end
            end

            add NSButton, :get_raw_tx_button do
              title "Get Raw Transaction"
              size_to_fit
              constraints do
                top.equals(:transaction_id, :bottom).plus(10)
                left.equals(:superview, :left).plus(10)
              end
            end

            add NSTextField, :get_raw_tx_result_label do
              stringValue "Raw Transaction:"
              bezeled false
              drawsBackground false
              editable false
              selectable false
              size_to_fit
              constraints do
                top.equals(:get_raw_tx_button, :bottom).plus(10)
                left.equals(:superview, :left).plus(10)
              end
            end

            add NSTextField, :raw_transaction do
              #size_to_fit
              constraints do
                top.equals(:get_raw_tx_result_label, :bottom).plus(10)
                left.equals(:superview, :left).plus(10)
                height.is(200)
                width.is(500)

              end
              editable false
            end

          end
        end
        add_tab "TabViewItem_AltTab", "Keys" do
          @alt_layout = AlternativeLayout.new
          self.addSubview(@alt_layout.view, positioned: NSWindowAbove, relativeTo: nil)

          add NSButton, :keys_button do
            title "Get Private and Public Key Pair"
            size_to_fit
            constraints do
              top.is(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :private_key_label do
            stringValue "Private Key 0x"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:keys_button, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :private_key_result do
            #size_to_fit
            constraints do
              top.equals(:private_key_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end

          add NSTextField, :public_key_label do
            stringValue "Public Key 0x"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:private_key_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :public_key_result do
            #size_to_fit
            constraints do
              top.equals(:public_key_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end

          add NSTextField, :uncompressed_public_key_label do
            stringValue "Uncompressed Public Key 0x"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:public_key_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :uncompressed_public_key_result do
            #size_to_fit
            constraints do
              top.equals(:uncompressed_public_key_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end

          add NSTextField, :compressed_public_key_label do
            stringValue "Compressed Public Key 0x"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:uncompressed_public_key_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end


          add NSTextField, :compressed_public_key_result do
            #size_to_fit
            constraints do
              top.equals(:compressed_public_key_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end


          add NSTextField, :public_key_hash_label do
            stringValue "Public Key Hash (20 bytes/ 40 Hex digits) (Version '00' and Checksum are not shown) 0x"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:compressed_public_key_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end


          add NSTextField, :public_key_hash_result do
            #size_to_fit
            constraints do
              top.equals(:public_key_hash_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end


          add NSTextField, :public_key_address_label do
            stringValue "Public Key Address (Base58Check)"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:public_key_hash_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end


          add NSTextField, :public_key_address_result do
            #size_to_fit
            constraints do
              top.equals(:public_key_address_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end

        end

        add_tab "TabViewItem_AltTab", "Transaction" do
          # @alt_layout = AlternativeLayout.new
          # self.addSubview(@alt_layout.view, positioned: NSWindowAbove, relativeTo: nil)

          add NSButton, :transaction_button do
            title "Build Coinbase Transaction"
            size_to_fit
            constraints do
              top.is(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :txo_pay_label do
            stringValue "Tx Output for Pay"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:transaction_button, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :txo_pay_result do
            #size_to_fit
            constraints do
              top.equals(:txo_pay_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end


          add NSTextField, :txo_change_label do
            stringValue "Tx Output for Change"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txo_pay_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :txo_change_result do
            #size_to_fit
            constraints do
              top.equals(:txo_change_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end



          add NSTextField, :txin_label do
            stringValue "Tx In"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txo_change_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :txin_result do
            #size_to_fit
            constraints do
              top.equals(:txin_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end

          add NSTextField, :txid_label do
            stringValue "Tx ID"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txin_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :txid_result do
            #size_to_fit
            constraints do
              top.equals(:txid_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(50)
              width.is(500)

            end
            editable false
          end

          add NSTextField, :tx_payload_label do
            stringValue "Tx Payload 0x"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txid_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
            end
          end

          add NSTextField, :tx_payload_result do
            #size_to_fit
            constraints do
              top.equals(:tx_payload_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(10)
              height.is(100)
              width.is(500)

            end
            editable false
          end







          add NSButton, :transaction2_button do
            title "Spend the Coinbase Transaction"
            size_to_fit
            constraints do
              top.is(10)
              left.equals(:superview, :left).plus(550)
            end
          end

          add NSTextField, :txo2_pay_label do
            stringValue "Tx Output for Pay"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:transaction2_button, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
            end
          end

          add NSTextField, :txo2_pay_result do
            #size_to_fit
            constraints do
              top.equals(:txo2_pay_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
              height.is(50)
              width.is(500)

            end
            editable false
          end


          add NSTextField, :txo2_change_label do
            stringValue "Tx Output for Change"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txo2_pay_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
            end
          end

          add NSTextField, :txo2_change_result do
            #size_to_fit
            constraints do
              top.equals(:txo2_change_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
              height.is(50)
              width.is(500)

            end
            editable false
          end



          add NSTextField, :txin2_label do
            stringValue "Tx In"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txo2_change_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
            end
          end

          add NSTextField, :txin2_result do
            #size_to_fit
            constraints do
              top.equals(:txin2_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
              height.is(50)
              width.is(500)

            end
            editable false
          end

          add NSTextField, :txid2_label do
            stringValue "Tx ID"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txin2_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
            end
          end

          add NSTextField, :txid2_result do
            #size_to_fit
            constraints do
              top.equals(:txid2_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
              height.is(50)
              width.is(500)

            end
            editable false
          end

          add NSTextField, :tx2_payload_label do
            stringValue "Tx Payload 0x"
            bezeled false
            drawsBackground false
            editable false
            selectable false
            size_to_fit
            constraints do
              top.equals(:txid2_result, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
            end
          end

          add NSTextField, :tx2_payload_result do
            #size_to_fit
            constraints do
              top.equals(:tx2_payload_label, :bottom).plus(10)
              left.equals(:superview, :left).plus(550)
              height.is(100)
              width.is(500)

            end
            editable false
          end






        end
      end
    end
  end
end
