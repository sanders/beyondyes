class SpecialController < ApplicationController
  def remind_password
    @title = "Password Reminder"
  end

  def signup
    @title = "Sign Up"
  end

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
