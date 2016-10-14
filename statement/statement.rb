class Statement
  def initialize suffix = ""
    @records = []
    @suffix = suffix
  end

  def << record
    @records << record
  end

  def export_csv file
    CSV.open(file + @suffix, "wb") do |csv|
      headers = @records.first.csv_headers
      csv << headers
      @records.each do |record|
        csv << record.csv_dump(headers)
      end
    end
  end
end