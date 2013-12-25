require 'vcr'
require 'rack'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock
  c.register_request_matcher :fatsecret do |request_1, request_2|
    params1 = Rack::Utils.parse_nested_query(request_1.uri)
    params2 = Rack::Utils.parse_nested_query(request_2.uri)
    params1.keys.select{|k| !k.start_with?("oauth")}.all? do |key|
      params1[key] == params2[key]
    end
  end
end
