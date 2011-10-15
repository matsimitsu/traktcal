require 'uri'
require 'yajl'
require 'digest/sha1'
require 'curb'

module Trakt

  def self.base_url
    "http://api.trakt.tv"
  end

  def self.external_url(url)
    return unless url
    "#{root_url}#{url.gsub('public/', '')}"
  end

  class Base
    attr_accessor :results, :username, :password

    def base_url
      Trakt::base_url
    end

    def request
      c = Curl::Easy.new(url)
      c.http_auth_types = :basic
      if username && password
        c.username = username
        c.password = password
      end
      c.perform
      parser = Yajl::Parser.new
      parser.parse(c.body_str)
    end
  end

  module User

    class Base < Trakt::Base

      def initialize(username, password)
        self.username = username
        self.password = password
        self.results = request
      end

    end

    class Calendar < Trakt::User::Base

      def url
        "#{base_url}/user/calendar/shows.json/#{Trakt::API_KEY}/#{username}"
      end
    end
  end
end