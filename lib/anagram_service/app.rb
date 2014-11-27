require 'rack/request'
require 'rack/response'
require 'json'

module AnagramService
  class App
    def initialize(index)
      @index = index
    end

    def call(env)
      req      = Rack::Request.new(env)
      words    = req.path[1..-1].split(',')
      anagrams = @index.lookup_words(words).to_json

      Rack::Response.new([anagrams], 200, {'ContentType' => 'application/json'})
    end
  end
end
