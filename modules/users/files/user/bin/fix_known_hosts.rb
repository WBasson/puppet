#!/usr/bin/env ruby

require 'socket'

custom_ports = {
  3022 => '^.+\.((atpla|host-h)\.net|atplanet\.co\.(uk|za))$',
  8697 => '^.+\.tracks4africa\.co\.za$',
}

ARGF.each do |line|
  pieces = line.split
  host = pieces.shift
  if host =~ /^[a-z0-9\.\-_]+$/ and host =~ /[a-z]/
    ip = IPSocket::getaddress(host)
    component = nil
    custom_ports.each do |port, regex|
      if host.match(/#{regex}/)
        component = "[#{host}]:#{port},[#{ip}]:#{port}"
        break
      end
    end
    if component
      puts "#{component} #{pieces.join(' ')}"
    else
      puts "#{host},#{ip} #{pieces.join(' ')}"
    end
  else
    puts line
  end
end
