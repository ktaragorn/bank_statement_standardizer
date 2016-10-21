require_relative "parsers/dbs_credit_card_parser"
require_relative "parsers/ocbc_credit_cards_parser"
require_relative "parsers/ocbc_bank_account_parser"
require_relative "parsers/posb_account_parser"

class String
  def titleize
    split(/(\W)/).map(&:capitalize).join
  end
end


get "/" do
  slim :index
end

post "/standardize" do
  out_dir = settings.public_dir + "/statements/"
  FileUtils.remove_dir(out_dir) if Dir.exists? out_dir
  FileUtils.mkdir_p(out_dir)
  out_file = out_dir + "bank_statement" + "_" + params[:type].to_s
  parser = Parser.types[params[:type].to_s].new(params[:statement][:tempfile].path)
  statements = parser.parse_into out_file
  slim :standardized, locals: {statements: statements}
  # send_file statements.first
end