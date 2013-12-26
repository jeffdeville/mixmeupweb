module PageEnumerator
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def for_all_pages
      (0..Float::INFINITY).each do |page_number|
        yield page_number
      end
    end
  end
end
