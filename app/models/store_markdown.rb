class StoreMarkdown < ActiveRecord::Base
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    col_names = StoreMarkdown.column_names
    col_names -= %w[updated_at created_at id]
    diff = header - col_names
    puts '=================='

    puts "diff" + " " + diff
    puts '=================='
    puts col_names
    raise ColumnError, "Column Name Do not Match, #{diff} is not found in db" unless diff.empty?


    (2..spreadsheet.last_row).each do |i|
      puts row = Hash[[header,spreadsheet.row(i)].transpose]
      markdown = find_by_id(row["id"]) || new
      markdown.attributes = row.to_hash.slice(*markdown.attribute_names())

      markdown.save!
    end

    # StoreMarkdown.all.each do |markdown|
    #   duplicated = StoreMarkdown.find_each item_name: markdown.item_name
    #   puts duplicated
    #   red

    #   if duplicated.size > 0
    #     markdown.colour = markdown.colour + ",#{duplicated.map(&:colour).join(',')}"
    #     markdown.save!
    #     duplicated.destroy_all
    #   end
    #end





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

class ColumnError < StandardError
end
