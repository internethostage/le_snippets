class LanguagesController < ApplicationController

  def index
    @languages = Language.all
  end

  def show
    @language = Language.find params[:id]
    # TODO @snippets = @language.snippets
  end

end
