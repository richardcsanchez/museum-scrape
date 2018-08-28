require 'bundler/setup'
Bundler.require(:development, :default)

require 'nokogiri'
require 'open-uri'
require 'pry'
require 'httparty'
require 'colorize'

require_relative "../lib/scraper.rb"
require_relative "../lib/museums.rb"
require_relative "../lib/cli.rb"
