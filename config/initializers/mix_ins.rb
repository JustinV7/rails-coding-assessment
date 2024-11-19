class NilClass
  def valid_json?
    false
  end
end

class String
  def valid_json?
    begin
      JSON.parse(self)
      true
    rescue
      false
    end
  end

  def valid_csv?
    begin
      CSV.parse(self)
      true
    rescue
      false
    end
  end
end

class Time
  def to_epoch
    (self.to_f * 1000).to_i
  end
end
