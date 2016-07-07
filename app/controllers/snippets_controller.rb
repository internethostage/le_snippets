class SnippetsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_snippet, only: [:show, :edit, :update, :destroy]

  def index
    @snippets = Snippet.where(private: false).or(Snippet.where(user: current_user)).order(:name)
  end

  def show
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new snippet_params
    @snippet.user = current_user
    if @snippet.save
      redirect_to @snippet, notice: "Snippet added"
    else
      flash.now[:alert] = "Snippet was not saved..."
      render :new
    end
  end

  def edit
    redirect_to root_path, alert: "access denied" unless can? :destroy, @snippet
  end

  def update
    redirect_to root_path, alert: "access denied" unless can? :update, @snippet
    if @snippet.update snippet_params
      redirect_to snippet_path(@snippet)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: "access denied" unless can? :destroy, @snippet
    @snippet.destroy
    redirect_to snippets_path
  end

  private

  def snippet_params
    params.require(:snippet).permit(:name, :body, :language_id, :private)
  end

  def find_snippet
    @snippet = Snippet.find params[:id]
  end

end
