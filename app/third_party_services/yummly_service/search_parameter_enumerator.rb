module YummlyService
  class SearchParameterEnumerator
    include Enumerable
    include PageEnumerator
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
      SearchParameterEnumerator.for_all_pages do |page_number|
        params = {
          "allowedIngredient[]" => alcohol,
          "allowedCourse[]" => course,
          maxResult: PAGE_SIZE, start: PAGE_SIZE * page_number
        }
        yield params
      end
    end
  end
end
