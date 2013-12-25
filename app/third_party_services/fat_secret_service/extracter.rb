module FatSecretService
  module Extracter
    extend self
    include PageEnumerator
    def get_alcohols
      results = []
      for_all_pages do |page_number|
        page_results = FatSecret.search_food('alcohol', page_number).with_indifferent_access[:foods][:food].
          select{|food| food[:food_type] == "Generic"}
        break if page_results.count == 0
        page_results.each{|food| yield food } if block_given?
        results += page_results
      end
      results
    end
  end
end
