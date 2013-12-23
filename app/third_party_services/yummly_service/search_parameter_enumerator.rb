module YummlyService
  class SearchParameterEnumerator
    include Enumerable
    PAGE_SIZE = 40
    attr_accessor :alcohol, :course

    def initialize(alcohol, course)
      @alcohol = alcohol
      @course = course
    end

    def self.courses
      %w(course^course-Beverages course^course-Cocktails)
    end

    def each &block
      for_all_pages do |page_number|
        params = {
          "allowedIngredient[]" => alcohol,
          "allowedCourse[]" => course,
          maxResult: PAGE_SIZE, start: PAGE_SIZE * page_number
        }
        yield params
      end
    end

    private

    def for_all_pages
      (0..Float::INFINITY).each do |page_number|
        yield page_number
      end
    end
  end
end
