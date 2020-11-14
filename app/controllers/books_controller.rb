class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_check, only: [:settings]
  before_action :approval_check, only: [:update, :create, :destroy, :edit]
  # skip_before_action :authenticate_user!, only: [:dashboard]


  def settings
    @users = User.all
    @groups = Group.all
    @memberships = Membership.all
    @members = Membership.new
    
    if params[:update] == 'true' and current_user.admin == true
      Rails.logger.info "==================================="
      Rails.logger.info "Redirect Settings - All Memberships"
      Rails.logger.info "==================================="
      Membership.all_memberships_update
      redirect_to settings_path
    end
  end

  def search
      # Rails.logger.info "search:" + params[:search]
      # Rails.logger.info "params: '" + params[:params] + "'"
      @search = params[:search]
      @params = params[:params]

    if params[:search].to_s == ''
      Rails.logger.info "Redirect Root"

    end
    
    if params[:search] == nil
      redirect_to root_path
    elsif params[:search] == "Title"
      @results = Book.search_by_title(params[:params]).reorder(:Author_Last, :Author_first, :Title) 

    elsif params[:search] == "Call_num"
      @results = Book.search_by_call_number(params[:params]).reorder(:Author_Last, :Author_first, :Title) 

    elsif params[:search] == "Subject"
      @results = Book.search_by_subject(params[:params]).reorder(:Author_Last, :Author_first, :Title) 

    elsif params[:search] == "Author"
      @results = Book.search_by_full_name(params[:params]).reorder(:Author_Last, :Author_first, :Title) 

    elsif params[:search] == "Copyright"
      @results = Book.where('Copyright' => params[:params]).reorder(:Author_Last, :Author_first, :Title) 
    end
     
  end

  # GET /books
  # GET /books.json
  def index
    # @books = Book.all
    @books = Book.paginate(page: params[:page], per_page: 100)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:Call_num, :Title, :Subtitle, :Author_first, :Author_Last, :Copyright, :Subject, :Annotation, :status)
    end
end
