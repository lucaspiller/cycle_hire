# encoding: utf-8

require 'nokogiri'

class CycleHire::JourneyParser
  def initialize(data)
    @data = data
  end

  def parse
    rows = rows_from_data(@data)
    rows.collect do |row|
      columns = column_data_for_row(row)

      # ignore the header and other column types
      if columns[4] == 'Hire'
        start_time = parse_time(columns[0])
        end_time = parse_time(columns[1])
        cost = parse_cost(columns[5])
        CycleHire::Journey.new(start_time, columns[2], end_time, columns[3], cost)
      else
        nil
      end
    end.compact
  end

  protected

  def rows_from_data(data)
    doc = Nokogiri::HTML(data)
    rows = doc.xpath("//table[@summary='My Account - Activity log']/tbody/tr")
  end

  def column_data_for_row(row)
    row.xpath('td').collect do |column|
      column.inner_text.strip
    end
  end

  # the data in the tables is seperated by a br, which the inner_text
  # method strips, as such dates come in as "11 Oct 201109:15"
  def parse_time(string)
    if string =~ /(.*)([0-9]{2}:[0-9]{2})/
      Time.parse($1 + " " + $2 + " London")
    end
  end

  def parse_cost(string)
    if string =~ /£([0-9]+\.[0-9]{2})/
      $1.to_f
    end
  end
end
