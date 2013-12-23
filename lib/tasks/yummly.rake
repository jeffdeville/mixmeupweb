require 'vcr'

# This should really only be saving me the calls that hit the search api.
# Get queries are only requested if the cache is missing the data.
VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock
end

namespace :yummly do
  desc "load data from yummly into mongo for later processing"
  task :cache => :environment do
    YummlyService::Tasks.cache
  end

  desc "process mongo data into postgres"
  task :load => :environment do
    YummlyService::Tasks.load
  end

  private
  def upsert(recipe, client)
    client.insert(recipe)
  end

  def cache
    @cache ||= YummlyService::Cacher.new
  end
end
