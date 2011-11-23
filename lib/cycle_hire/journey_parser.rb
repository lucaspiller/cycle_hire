# encoding: utf-8

require 'nokogiri'

class CycleHire::JourneyParser
  def parse(body)
    rows = rows_from_body(body)
    rows.collect do |row|
      columns = column_data_for_row(row)

      # ignore the header and other column types
      if columns[4] == 'Hire'
        start_time = parse_time(columns[0])
        end_time = parse_time(columns[1])
        cost = parse_cost(columns[5])
        duration = ((end_time - start_time) / 60).to_i
        {
          :start_time => start_time,
          :start_station => columns[2],
          :end_time => end_time,
          :end_station => columns[3],
          :cost => cost,
          :duration => duration
        }
      else
        nil
      end
    end.compact
  end

  protected

  def rows_from_body(body)
    doc = Nokogiri::HTML(body)
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
