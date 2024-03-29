Gem::Specification.new do |s|
  s.name              = "cycle_hire"
  s.version           = "1.0.3"
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A Ruby API for the Barclays Cycle Hire scheme in London"
  s.homepage          = "https://github.com/lucaspiller/cycle_hire"
  s.email             = "luca@stackednotion.com"
  s.authors           = [ "Luca Spiller" ]

  s.files             = %w( README.md )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")

  s.require_path      = 'lib'

  s.executables       = %w( cycle_hire_history cycle_hire_status )

  s.add_dependency('httparty', '>= 0.8')
  s.add_dependency('nokogiri', '>= 1.5')
end
