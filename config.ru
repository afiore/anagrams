$LOAD_PATH << File.join(__dir__, 'lib')

require 'logger'
require 'rack'
require 'anagram_service'
require 'anagram_service/index'
require 'anagram_service/app'

logger  = Logger.new(STDOUT)
logger.info "Indexing words... This might take a few minutes!"
index = AnagramService::Index.from_wordfile
logger.info "Done indexing."

use Rack::ShowExceptions
#use Rack::CommonLogger, logger
run AnagramService::App.new(index)
