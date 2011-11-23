# Cycle Hire

Cycle Hire is a Ruby API for the Barclays Cycle Hire scheme in London. It primarily works by scraping the TfL website.

It provides access to the following data:

* User journey history
* Docking station status

## Requirements

Ruby 1.9 and Bundler. (It'll probably work on Ruby 1.8 but is untested)

Bundler installs:

* Nokogiri
* HTTParty

## Usage (binaries)

### Fetch journey history

    ./bin/cycle_hire_history <email> <password>

Where the access credentials are your login to the cycle hire section of the TfL website. Outputs the data in YAML format.

### Fetch docking station status

    ./bin/cycle_hire_status <station>

Where station is a regex of stations you want to match. Outputs the data in YAML format.

## Usage (in your code)

### Fetch journey history

      session = CycleHire.authenticate email, password
      # raises CycleHire::Session::AuthenticationError if
      # the email or password and incorrect

      journeys = session.journeys
      # array of the users journeys

### Fetch docking station status

      stations = CycleHire.stations
      # array of stations, see CycleHire::Station
      # for more details

## Todo

* Tests
* Access to more user account data (e.g. balance, membership expiry)

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.
* Add tests for what you are building, and make sure you don't break any existing tests.

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/InteractiveResource" property="dct:title" rel="dct:type">cycle-hire</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/lucaspiller/cycle-hire" property="cc:attributionName" rel="cc:attributionURL">Luca Spiller</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/lucaspiller/cycle-hire" rel="dct:source">github.com</a>.<br />Permissions beyond the scope of this license may be available at <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/lucaspiller/cycle-hire" rel="cc:morePermissions">https://github.com/lucaspiller/cycle-hire</a>.
