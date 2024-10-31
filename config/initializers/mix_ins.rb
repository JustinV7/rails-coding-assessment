class Time
  def to_epoch
    (self.to_f * 1000).to_i
  end
end
