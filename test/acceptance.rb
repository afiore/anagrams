require 'rack/test'
require 'test/unit'

APP, _ = Rack::Builder.parse_file('config.ru')

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    APP
  end

  def test_single_word_lookup
    get '/crepitus'
    anagrams = JSON.parse(last_response.body).fetch('crepitus')
    assert_equal ["cuprites","pictures","piecrust"], anagrams
  end

  def test_multiple_words_lookup
    get '/crepitus,paste,kinship,enlist,boaster,fresher,refresh,sinks,knits,sort'
    anagrams = JSON.parse(last_response.body)
    assert_equal ["cuprites","pictures","piecrust"], anagrams.fetch('crepitus')
    assert_equal ["pates","peats","septa","spate","tapes","tepas"], anagrams.fetch('paste')
    assert_equal ["pinkish"], anagrams.fetch('kinship')
    assert_equal ["elints","inlets","listen","silent","tinsel"], anagrams.fetch('enlist')
    assert_equal ["boaters","borates","rebatos","sorbate"], anagrams.fetch('boaster')
    assert_equal ["refresh"], anagrams.fetch('fresher')
    assert_equal ["fresher"], anagrams.fetch('refresh')
    assert_equal ["skint","stink","tinks"], anagrams.fetch('knits')
    assert_equal ["orts","rots","stor","tors"], anagrams.fetch('sort')
  end

  def test_missing_word_lookup
    get '/missing-word'
    anagrams = JSON.parse(last_response.body).fetch('missing-word')
    assert_equal [], anagrams
  end
end
