require_relative "../statement/statement"
require_relative "../statement/statement_record"
class Parser
  attr_reader :statement
  def initialize input
    @statement = Statement.new
    @statement_record = nil
    _parse_file input
    _finalize_statement
  end
  def parse_into output
    @statement.export_csv(output)
  end

  def _parse_file input
    raise NotImplementedError, "Implement this method on individual parsers"
  end

  def _write_to_statement
    @statement << @statement_record if @statement_record
    @statement_record = nil
  end

  def _finalize_statement
    # any final steps to statement should go here
    _write_to_statement
  end
end