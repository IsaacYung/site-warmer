class Numeric
  def percent_of(n)
   (self.to_f / n.to_f * 100.0).to_i
  end
end
