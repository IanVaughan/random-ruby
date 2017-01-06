#!/usr/bin/env ruby

# Copyright 2011 Marc Hedlund <marc@precipice.org>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# campfire_export -- export Campfire transcripts and uploaded files.
#
# Since Campfire (www.campfirenow.com) doesn't provide an export feature,
# this script implements one via the Campfire API.
#
# See https://github.com/precipice/campfire_export/blob/master/README.md
# for more information on using this script.

lib = File.expand_path(File.join(File.dirname(__FILE__), '../lib'))
$LOAD_PATH.unshift(lib) if File.directory?(lib) && !$LOAD_PATH.include?(lib)

require 'campfire_export'

def config_date(config, date_key)
  date_str = config.fetch(date_key, nil)
  date_str.nil? ? nil : Date.parse(date_str)
end

def ensure_config_for(config, key, prompt)
  value = config.fetch(key, "")
  while value == ""
    print "#{prompt}: "
    value = gets.chomp
  end
  config[key] = value
end

config = {}
config_file = File.join(ENV['HOME'], '.campfire_export.yaml')

if File.exists?(config_file) and File.readable?(config_file)
  config = YAML.load_file(config_file)
end

ensure_config_for(config, 'subdomain',
  "Your Campfire subdomain (for 'https://myco.campfirenow.com', use 'myco')")
ensure_config_for(config, 'api_token',
  "Your Campfire API token (see 'My Info' on your Campfire site)")

# begin
  account = CampfireExport::Account.new(config['subdomain'],
                                        config['api_token'])
  account.find_timezone # move into Account

  puts "=> Found rooms : " + account.rooms.map {|r| r.name }.join(", ")

  rooms = if config.has_key?('included_rooms')
    account.rooms.keep_if do |found_room|
      config['included_rooms'].any? do |included_room|
        included_room.upcase == found_room.name.upcase
      end
    end
  elsif config.has_key?('excluded_rooms')
    account.rooms.delete_if do |found_room|
      config['excluded_rooms'].any? do |included_room|
        included_room.upcase == found_room.name.upcase
      end
    end
  else
    account.rooms
  end

  puts "=> Using rooms : " + rooms.map {|r| r.name }.join(", ")

  rooms.each do |room|
    puts "=> Reading room : #{room.name}"
    room.export(config_date(config, 'start_date'),
                config_date(config, 'end_date'))
  end
# rescue => e
#   puts "Unable to export account: #{e}"
# end
