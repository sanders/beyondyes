# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def login_widget_hide_form?(params)
    return ' style="display:none"' if params[:for] != params[:given]
  end
end
