class LinksController < ApplicationController
  before_action :set_link, only: [:link_through, :edit, :expire]


  # GET /links/1
  # GET /links/1.json
  def link_through
      @link.increment_uses!
      redirect_to(@link.url)
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to edit_link_url(@link), notice: 'Link was successfully created.' }
        format.json { render :edit, status: :created, location: edit_link_url(@link) }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /links/1
  # DELETE /links/1.json
  def expire
      @link.expire!
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'Link was successfully expired.' }
        format.json { head :no_content }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find_by(slug: params[:slug])
      if bad_link?
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url)
    end

    def bad_link?
      return @link.blank? || @link.expired?
    end
end
