class StoreMarkdown < ActiveRecord::Base
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    puts '=================='
    col_names = StoreMarkdown.column_names
    diff = header - col_names
    raise ArgumentError, "Column Name Do not Match" unless diff.empty?

    puts '=================='



    (2..spreadsheet.last_row).each do |i|
      puts row = Hash[[header,spreadsheet.row(i)].transpose]
      markdown = find_by_id(row["id"]) || new

      markdown.attributes = row.to_hash.slice(*markdown.attribute_names())

      markdown.save!
    end





  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise UnknownFileType, "Unknown file type: #{file.original_filename}"
      redirect_to root_path
    end
  end


end

class UnknownFileType < StandardError
end
