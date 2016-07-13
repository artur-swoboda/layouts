require 'psd'
require 'json'
require 'benchmark'

time = Benchmark.measure do
  (1..10000).each { |i| i }

  psd_hash = ""
  PSD.open('test.psd', "w") do |psd|
  	psd_hash = psd.tree.to_hash
  end

  psd_hash = JSON.generate(psd_hash)
  psd_hash = psd_hash.encode('UTF-8',
  	'binary',
  	invalid: :replace, 
  	undef: :replace, 
  	replace: '')

  # print psd_hash
  File.open('test.json',"w") do |file|
  	file.write(psd_hash)
  end

end

puts time


# array = (1..100000000).map { rand }

# Benchmark.bmbm do |x|
#   x.report("sort!") { array.dup.sort! }
#   x.report("sort")  { array.dup.sort  }
# end

#   1.250000   0.010000   1.260000 (  1.250334)
# Rehearsal -----------------------------------------
# sort!  75.880000   1.000000  76.880000 ( 76.943936)
# sort   77.620000   0.130000  77.750000 ( 77.772689)
# ------------------------------ total: 154.630000sec

#             user     system      total        real
# sort!  79.050000   0.110000  79.160000 ( 79.183300)
# sort   79.270000   0.470000  79.740000 ( 79.760715)
