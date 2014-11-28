$LOAD_PATH << File.join(__dir__, 'lib')

require 'logger'
require 'rack'
require 'anagram_service'
require 'anagram_service/index'
require 'anagram_service/app'

logger  = Logger.new(STDOUT)
logger.info "Indexing words..."
index = AnagramService::Index.from_wordfile
logger.info "Done indexing."

use Rack::ShowExceptions
use Rack::CommonLogger
run AnagramService::App.new(index)
