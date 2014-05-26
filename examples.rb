#!/bin/env ruby
# encoding: utf-8

require_relative 'ledborg'

  if ARGV[0].nil?
    puts "\n  usage: #{$0} blink | sequence_random_full | sequence_random_list"
    puts "example: ruby #{$0} blink\n\n"
    exit 2
  end

action = ARGV[0]

led = LEDBORG.new

if action == "blink"
  led.blink
elsif action == "sequence_random_full"
  led.sequence_random_full
elsif action == "sequence_random_list"
  led.sequence_random_list
else
  puts "unknown action :-("
end
