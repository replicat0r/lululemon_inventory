class StoreMarkdownsController < ApplicationController
  before_action :authenticate_user!


  def index
    @markdowns = StoreMarkdown.all.paginate(:per_page => 50,:page => params[:page])
    @column_names=StoreMarkdown.column_names

    # @column_names.delete('updated_at')
    # @column_names.delete('id')
    # @column_names.delete('created_at')

    @column_names -= %w[updated_at created_at id]
  end

  def update
    @markdown = StoreMarkdown.find(params[:id])
    @markdown.update_attributes(markdown_params)
    respond_to do |format|
      format.html {redirect_to :action => "index"}
      format.json {render :json => @markdown}
    end

  end

  def import
    if params[:file]
      begin
        StoreMarkdown.import(params[:file])
        flash[:success] = "The MarkDown Sheet has been successfully imported!"
      rescue UnknownFileType
        flash[:error] = "Incorrect File Type, Must be .xlxs"
      rescue ColumnError
        flash[:error] = "The Column Name On the Excel Sheet Is Incorrect"
      ensure
        redirect_to :action => 'index'
      end
    else
      flash[:notice] = "No File Imported"

      redirect_to :action => 'index'
    end


    # redirect_to :action => 'index'
  end

  private
  def markdown_params
    params.require(:store_markdown).permit(:item_name,:colour,:original_price,:current_price,:initials,:date_changed)
  end
end
