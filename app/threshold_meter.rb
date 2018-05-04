class ThresholdMeter < NSView
  Threshold = Struct.new(:start, :finish, :color)
  attr_accessor :min_value, :max_value, :value, :thresholds
  def add_threshold(start, finish, color)
    self.thresholds ||= []
    self.thresholds << Threshold.new(start, finish, color)
  end

  def range
    self.max_value - self.min_value
  end

  def draw_width
    (self.bounds.size.width / self.range.to_f) * ((self.value || 0) - self.min_value)
  end

  def value=(value)
    @value = value
    self.needsDisplay = true
  end

  def drawRect(frame)
    frame.size = [self.draw_width, frame.size.height]
    if (self.thresholds || []).any?
      threshold = self.thresholds.detect {|threshold| threshold.start < (self.value || 0) && threshold.finish > (self.value || 0)}
      color = threshold.color unless threshold.nil?
    end
    (color || NSColor.greenColor).setFill
    NSRectFill(frame)
  end
end
