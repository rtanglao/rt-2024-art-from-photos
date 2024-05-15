#!/usr/bin/env ruby
require 'rubygems'
require 'amazing_print'
require 'logger'
require 'mini_magick'
require 'rake'
logger = Logger.new($stderr)
logger.level = Logger::DEBUG

ARGF.each_line.with_index do |photo_filename, i|
  p photo_filename.chomp, i + 1
  photo_without_dot_slash = photo_filename.chomp[2..]
  image = MiniMagick::Image.open(photo_without_dot_slash)
  image.resize '20x20'
  image.format 'png'
  logger.debug "photo_without_dot_slash:#{photo_without_dot_slash}"
  dirname = File.dirname(photo_without_dot_slash)
  filename = "THUMBS/#{format('%5.5d', (i + 1))}-#{dirname}-#{File.basename(photo_without_dot_slash)}".ext('png')
  logger.debug "filename:#{filename}"
  image.write filename
end
