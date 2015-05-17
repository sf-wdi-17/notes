class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def new
    @author = Author.new
  end

  def create
    author_params = params.require(:author).permit(:name)
    @author = Author.create(author_params)
    redirect_to @author
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    author_params = params.require(:author).permit(:id, :name)
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to @author
    else
      render :edit
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    redirect_to authors_path, Notice: "The author was successfully destroyed."
  end
end
