class AlternativeLayout < MotionKit::Layout
  SIDEBAR_WIDTH = 150
  view :alt_content

  def layout

    add NSView, :alt_content do
      wantsLayer true
      constraints do
        height.is(200)
        width.is(200)
        left.is(0)
      end
      backgroundColor NSColor.blueColor

      add NSTextField, :alt_text_id do
        stringValue "Alternative"
        size_to_fit
        constraints do
          # top.equals(:superview, :top).minus(10)
          # left.equals(:superview, :left).plus(10)
          min_top.is 10
          min_left.is 10
        end
      end
    #
    end
    puts "Into the Alt Blue"
    @blue = self.get(:alt_text_id).stringValue
    puts @blue
  end
end
