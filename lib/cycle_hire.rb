module CycleHire
  ROOT = File.expand_path(File.dirname(__FILE__))

  autoload :Session, "#{ROOT}/cycle_hire/session"
  autoload :HistoryParser, "#{ROOT}/cycle_hire/history_parser"
end
