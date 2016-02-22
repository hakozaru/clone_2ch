class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def show
    @board = Board.includes(:comments).find(params[:id])
    @comment = Comment.new
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(get_board_params)
      redirect_to board_path(@board)
    else
      render 'edit'
    end
  end

  def create
    @board = Board.new(get_board_params)
    if @board.save
      redirect_to board_path(@board)
    else
      render 'new'
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
  end

  private

  def get_board_params
    params.require(:board).permit(:title, :editor)
  end
end
