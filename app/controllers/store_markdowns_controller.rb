class StoreMarkdownsController < ApplicationController
  layout 'admin'

  def index
  	@markdowns = StoreMarkdown.all.paginate(:per_page => 50,:page => params[:page])
  	@column_names=StoreMarkdown.column_names
  	
  	@column_names.delete('updated_at')
  	@column_names.delete('id')
  	@column_names.delete('created_at')
  end

  def update
  	@markdown = StoreMarkdown.find(params[:id])
  	@markdown.update_attributes(markdown_params)
  	respond_to do |format|
  		format.html {redirect_to :action => "index"}
  		format.json	{render :json => @markdown}
  	end

  end

  def import
  	StoreMarkdown.import(params[:file])
  	redirect_to :action => 'index'
  end

  private
  	def markdown_params
  		params.require(:store_markdown).permit(:item_name,:colour,:original_price,:current_price,:initials,:date_changed)
  	end
end
