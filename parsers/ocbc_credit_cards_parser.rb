require_relative "csv_parser"
class OCBCCreditCardParser < CSVParser
  register "ocbc_credit_cards", self
  # Main Credit CardOCBC 365 Credit Card 4524-1920-0283-6744
  # Transaction date  Description Withdrawals (SGD) Deposits (SGD)
  # 29/09/2016  CASH REBATE   1.41

  # Supplementary CardsOCBC 365 Credit Card 4524-1920-0270-4736
  # Transaction date  Description Withdrawals (SGD) Deposits (SGD)
  # 29/09/2016  JUICE BAR - 313 SOMERSET SINGAPORE    SG  1.6

  def _parse_line line
    # note there could be multiple Supplementary cards
    if line[0].start_with? "Main"
      @statement.suffix = "_main"
    elsif line[0].start_with? "Supplementary"
      _new_statement "_supp"
    end
    return unless (Date.parse(line[0]) rescue false)
    _write_to_statement line[0], line[1], line[2], line[3]
  end
end