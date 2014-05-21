require_relative 'kaf_to_json/version'
require_relative 'kaf_to_json/server'

require 'json'
require 'nokogiri'



module Opener
  ##
  # Primary POS tagger class that delegates work the various POS tagging
  # kernels.
  #
  # @!attribute [r] options
  #  @return [Hash]
  #
  class KafToJson
    attr_reader :options

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args => []
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Arbitrary arguments to pass to the
    #  underlying kernel.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Processes the input and returns an Array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input The input to process.
    # @return [Array]
    #
    def run(input)
      doc = Nokogiri::XML(input)
      xslt = Nokogiri::XSLT(File.read(xsl))
      xslt.apply_to(doc)
    end
    
    alias tag run
    
    def output_type
      return :json
    end
    
    private
    
    ##
    # @return [String]
    #
    def config_dir
      return File.expand_path('../../../config', __FILE__)
    end

    ##
    # @return [String]
    #
    def xsl
      return File.join(config_dir, 'kaf2json.xsl')
    end
  end # KafToJson
end # Opener

