class GradientView < NSView
  def drawRect(rect)
    gradient = NSGradient.alloc.initWithStartingColor(NSColor.lightGrayColor, endingColor: NSColor.grayColor)
    gradient.drawInRect(rect, angle: rand(360))
  end
end
