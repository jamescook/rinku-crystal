require "autolink"
require "./src/rinku"
require "benchmark"

string = "Welcome to my new blog at http://www.myblog.com/" * 20
puts Rinku.auto_link(string) ==  Autolink.auto_link(string)

Benchmark.ips do |b|
  b.report("Autolink") { Autolink.auto_link(string) }
  b.report("Rinku") { Rinku.auto_link(string, :urls) }
end
