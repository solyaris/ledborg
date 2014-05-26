#!/bin/env ruby
# encoding: utf-8

class LEDBORG
  LED = '/dev/ledborg'

  RED             = "100"
  RED_HIGH        = "200"
  PINK            = "211"
  VERDONE         = "110"
  YELLOW_HIGH     = "220"
  YELLOW          = "221"
  GREY            = "111"
  WHITE           = "222"
  GREEN           = "010"
  GREEn_HIGH      = "020"
  VERDINO         = "121"
  BLUASTRO_HIGH   = "022"
  BLUASTRO        = "011"
  BLUASTRO_MEDIO  = "122"
  VERDASTRO       = "120"
  VERDASTRO_HIGH  = "021"
  ORANGE          = "210"
  BLUE            = "001"
  BLUE_HIGH       = "002"
  BLUASTRO_ALTO   = "112"
  MAGENTA         = "101"
  MAGENTA_HIGH    = "202"
  VIOLET          = "212"
  VIOLET_BLUE     = "012"
  VIOLET_BLUASTRO = "102"
  RED_HIGHEST     = "201"
  OFF             = "000"
  BLACK           = "000"


  def initialize(duration=0.500)
    @duration = duration # 500 msec
    @color = BLUE
    trap_shutdown
  end

  def on(color, duration=@duration)
    puts "on" if @debug
    @led = open LED, 'w'
    @led.write color
    @led.close
    sleep duration 
  end

  def off(duration=@duration)
    puts "off" if @debug
    @led = open LED, 'w'
    @led.write BLACK 
    @led.close
    sleep duration
  end

  def blink(color=@color, iterations=3, duration_on=@duration, duration_off=@duration)
    iterations.times do
      on color, duration_on
      off duration_off
    end
  end  

  def random_color
    "%d%d%d" % [rand(3), rand(3), rand(3)]
  end

  def random_color_from_list
    ["200", "210", "110", "120", "020", "021", "011", "012", "002", "102", "101", "201"].sample
  end

  def sequence_random_full(explain=false, duration_on=@duration, duration_off=0)
    loop do
      color = random_color
      puts "color is: #{color}" if explain
      on color, duration_on
      off duration_off if duration_off!=0
    end
  end

  def sequence_random_list(explain=false, duration_on=@duration, duration_off=0)
    loop do
      color = random_color_from_list
      puts "color is: #{color}" if explain
      on color, duration_on
      off duration_off if duration_off!=0
    end
  end

  def close
    @led = open LED, 'w'
    @led.write "000"
    @led.close
  end

  # when process will be killed.
  def trap_shutdown
    trap('INT') do
      close
      puts "ledborg has closed (crowd applauds)"
      exit 0
    end
  end
end

