#!/usr/bin/env ruby
###
## 
# msg-flukso-localinterface: A Ruby library for the Local Flukso
# Interface
# Copyright (C) 2010 Mathias Dalheimer (md@gonium.net)
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#  
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
##
###

libpath=File.join(File.dirname(__FILE__), '..', 'lib')
$:.unshift << libpath 
#puts "Using libraty path #{$:.join(":")}" 

require 'msg-flukso-localinterface'
require 'optparse'
require 'ostruct'

###
## Commandline parser
#
class Optparser
  CODES = %w[iso-2022-jp shift_jis euc-jp utf8 binary]
  CODE_ALIASES = { "jis" => "iso-2022-jp", "sjis" => "shift_jis" }
  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.inplace = false
    options.encoding = "utf8"
    options.verbose = false
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} [options]"
      opts.separator ""
      opts.separator "Specific options:"
      opts.on("-t", "--timerange VALUE", "The time range you want to query. Valid queries are: {hour, day, month, year, night}") do |timerange|
        options.timerange = timerange 
      end
      opts.on("-u", "--unit VALUE", "The unit you want to query. Valid queries are: {watt, kwh, eur, aud}") do |unit|
        options.unit = unit 
      end
      opts.on("-c", "--config FILE", "The file where the configuration lives.") do |file|
        options.config_file = file
      end
      # Boolean switch.
      opts.on("-v", "--verbose", "Run verbosely") do |v|
        options.verbose = v
      end
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
    opts.parse!(args)
    options
  end
end

###
## Script startup
#
options = Optparser.parse(ARGV)
$verbose = options.verbose

# TODO: Discover Flukso.
location=FluksoLocal::Location.new("192.168.1.102", 80);

# Now: Query the Flukso.
query=FluksoLocal::Query.new(location)
values=query.getReadings("d69779ec53a9323b695ee86b5328dd28");
puts "Retrieved #{values.size} seconds of data";
last_value=values.max
puts "Last reading: timestamp = #{last_value[0]}, value=#{last_value[1]}"
