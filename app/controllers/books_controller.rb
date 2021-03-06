class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :logined

  # GET /books
  # GET /books.json
  def index
    @books = current_user.books
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
    @book = current_user.books.build(book_params)

    # @book = Book.new(book_params)

    if File.exist?(Rails.root.join('public', params[:book][:name])) then
      # https://github.com/presidentbeef/brakeman/blob/master/docs/warning_types/file_access/index.markdown
      File.open(Rails.root.join('public', params[:book][:name]))
    end

    if params[:book][:name] == "id" then
      # https://github.com/presidentbeef/brakeman/blob/master/docs/warning_types/command_injection/index.markdown
      system(params[:book][:name])
      exec(params[:book][:name])
      `#{params[:book][:name]}`
    end 

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

    if params[:book][:description] == "https://google.co.jp/"
      # https://github.com/presidentbeef/brakeman/blob/master/docs/warning_types/redirect/index.markdown
      redirect_to params[:book][:description]
      return
    end

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
      params.require(:book).permit(:name, :price, :description)
    end
end
