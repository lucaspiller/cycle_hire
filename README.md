# Cycle Hire History

Cycle Hire History is a simple library the scrapes the TfL website to get your cycle history for the Barclays Cycle Hire scheme in London. At the moment it is a bit of a spike script, however I plan on tidying it up.

## Requirements

Ruby 1.9 and Bundler.

Bundler installs:

* Nokogiri
* HTTParty

## Usage

    bundle exec ./scraper.rb <username> <password>

Where the access credentials are your login to the cycle hire section of the TfL website.

## Todo

* Turn it into a library rather than just a script
* Better error handling

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.
* Add tests for what you are building, and make sure you don't break any existing tests.

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/InteractiveResource" property="dct:title" rel="dct:type">cycle-hire-history</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/lucaspiller/cycle-hire-history" property="cc:attributionName" rel="cc:attributionURL">Luca Spiller</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/lucaspiller/cycle-hire-history" rel="dct:source">github.com</a>.<br />Permissions beyond the scope of this license may be available at <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/lucaspiller/cycle-hire-history" rel="cc:morePermissions">https://github.com/lucaspiller/cycle-hire-history</a>.
