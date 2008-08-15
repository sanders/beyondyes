class SpecialController < ApplicationController
  def login
    @title = "Login"
  end

  def signin
    redirect_to :action => :login
  end

  def system
    @title = "System Information and Documentation"
  end
end
