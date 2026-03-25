class BooksController < ApplicationController

  def index
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @books = Book.where("title LIKE ? OR genre LIKE ?", search_term, search_term)
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @author = @book.author
  end

end