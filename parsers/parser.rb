require_relative "../statement/statement"
require_relative "../statement/statement_record"
class Parser
  attr_reader :statement
  def initialize input
    @statement = Statement.new
    _parse_file input
    _finalize_statement
  end
  def parse_into output
    @statement.export_csv(output)
  end

  def _finalize_statement
    # any final steps to statement should go here
  end

  def _parse_file input
    raise NotImplementedError, "Implement this method on individual parsers"
  end
end