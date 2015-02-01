class StoreMarkdownsController < ApplicationController
  layout 'admin'

  def index
  	@markdowns = StoreMarkdown.all
  	@column_names=StoreMarkdown.column_names
  	@column_names.slice!(0)
  end

  def update
  end
end
