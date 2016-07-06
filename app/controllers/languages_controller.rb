class LanguagesController < ApplicationController

  def index
    @languages = Language.order(:name)
  end

  def show
    @language = Language.find params[:id]
    @snippets = @language.snippets
  end

end
