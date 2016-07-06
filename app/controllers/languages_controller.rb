class LanguagesController < ApplicationController

  def index
    @snippets = Snippet.where(private: false).or(Snippet.where(user: current_user)).order(:name).group_by{|s| s.language.name}
  end

end
