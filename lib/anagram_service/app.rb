require 'rack/request'
require 'rack/response'
require 'json'

module AnagramService
  class App
    def initialize(index)
      @index = index
    end

    def call(env)
      request      = Rack::Request.new(env)
      words        = request.path[1..-1].split(',')
      status, body =
        if words.empty?
          [400, { error: "Bad request. Please supply a comma-separated list of words as the request path." }.to_json]
        else
          [200, @index.lookup_words(words).to_json]
        end

      Rack::Response.new([body], status, {'ContentType' => 'application/json'})
    end
  end
end
