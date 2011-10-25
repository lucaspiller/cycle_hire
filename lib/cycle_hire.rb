module CycleHire
  ROOT = File.expand_path(File.dirname(__FILE__))

  autoload :API, "#{ROOT}/cycle_hire/api"
  autoload :HistoryParser, "#{ROOT}/cycle_hire/history_parser"
end
