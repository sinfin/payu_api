require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'payu_api'

require 'minitest/autorun'
require 'webmock/minitest'
