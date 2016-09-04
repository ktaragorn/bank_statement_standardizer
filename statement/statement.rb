class Statement
  def initialize
    @records = []
  end

  def << record
    @records << record
  end

  def export_csv file
    file = File.open(file, "wb")
    CSV.dump(@records, file)
  end
end