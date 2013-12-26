module PageEnumerator
  def for_all_pages
    (0..Float::INFINITY).each do |page_number|
      yield page_number
    end
  end
end
