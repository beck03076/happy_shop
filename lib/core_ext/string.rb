# opening the numberic standard class to add 1 method
class String
  # convert to float and multiply by 100
  def to_cents
    (self.to_f * 100).round(2).to_i
  end
end
