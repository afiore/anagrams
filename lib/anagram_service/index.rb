require 'set'

module AnagramService
  class Index
    WORDS_FILE =
      File.expand_path('wordlist.txt',
                       File.join(__dir__, '..','..', 'resources'))

    def initialize(h)
      @anagrams = h
    end

    def lookup_words(words)
      words.reduce({}) do |acc, word|
        acc.merge(word => lookup_word(word))
      end
    end

    private

    def lookup_word(word)
      key = self.class.index_key(word)
      @anagrams.fetch(key, []) - [word]
    end

    def self.from_wordfile(words_file = WORDS_FILE)
      anagrams = {}

      IO.foreach(words_file) do |word|
        word.strip!
        anagrams.merge!(index_key(word) => [word]) do |_, words, new_words|
          words + new_words
        end
      end

      new(anagrams)
    end

    def self.index_key(word)
      word.chars.sort.join('')
    end
  end
end
