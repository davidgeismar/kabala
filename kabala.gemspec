Gem::Specification.new do |s|
  s.name        = 'kabala'
  s.version     = '0.0.1'
  s.executables << 'kabala_init'
  s.date        = '2019-05-28'
  s.summary     = "Kabala ^^"
  s.description = "A performance test automat"
  s.authors     = ["David GEISMAR"]
  s.email       = 'dageismar@gmail.com'
  s.files       = ["lib/kabala.rb", "lib/kabala/init.rb", "lib/kabala/action_performer.rb", "lib/kabala/config.rb", "lib/kabala/csv_file_path.rb", "lib/kabala/data_override_engine.rb", "lib/kabala/perf_tester.rb", "lib/kabala/performance_configuration.rb", "lib/kabala/report.rb", "lib/kabala/reporting_configuration.rb", "lib/kabala/script.rb", "lib/kabala/scripts_configuration.rb", "lib/kabala/semantics_configuration.rb"]
  s.homepage    =
    'https://rubygems.org/gems/kabala'
  s.license       = 'MIT'
end


# ruby -Ilib ./bin/kabala
