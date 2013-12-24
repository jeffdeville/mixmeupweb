class String
  def to_frac
    numerator, denominator = split('/').map(&:to_f)
    denominator ||= 1
    numerator/denominator
  end
end
