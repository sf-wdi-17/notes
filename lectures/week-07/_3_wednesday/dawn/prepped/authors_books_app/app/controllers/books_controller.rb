class BooksController < ApplicationController
  before_action :set_author
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    # Shows all books by a particular author, and thanks to our "before action", we should already have @author
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    book_params = params.require(:book).permit(:title)
    book = Book.create(book_params)
    @author.books << book # Associate the new book with the correct author
    # We could also associate in 1 step by saying: book = @author.books.create(book_params)
    redirect_to [@author, book]
  end

  def edit
  end

  def update
    book_params = params.require(:book).permit(:title)
    @book.update(book_params)
    redirect_to [@author, @book]
  end

  def destroy
    @book.destroy
    redirect_to author_books_path, Notice: "The book was successfully destroyed."
  end

  private
  def set_author
    @author = Author.find(params[:author_id])
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
