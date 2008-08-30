require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module UserSpecHelper
  def valid_attributes
    {
      :legal_name => "Brandon Clark Schoepflin Sanders",
      :name_key => "brandonclarkschoepflinsanders",
      :password => "PassWord",
      :password_verified => "PassWord",

      :email => "brandon@thesanders.us",

      :city => "Portland",
      :region => "Oregon",
      :postal_code => 97214,
      :country => "USA",

      :phone => "503.729.9269",

      :birthdate => Date.new(1975, 11, 23),
      :sex => :male,
      :sexual_orientation => :straight,
      :religious_affiliations => ["SolSeed Movement", "Unitarian Universalist"],
      :race => :caucasian,
      :height_inches => 75,
      :weight_lbs => 235,
      :marital_status => :married
    }
  end

  def brandon_signup_attributes
    {
      :legal_name => "Brandon Clark Schoepflin Sanders",
      :password => "PassWord",
      :password_verified => "PassWord",
      :email => "brandon@thesanders.us"
    }
  end
end

describe User do
  include UserSpecHelper

  it "should create a new instance given valid attributes" do
    User.create!(valid_attributes)
  end
end

describe User, "signup" do
  include UserSpecHelper

  before(:each) do
    @brandon_signup_attributes = brandon_signup_attributes
  end

  it "should raise an error if passwords don't match" do
    lambda {
      @brandon_signup_attributes[:password_verified] = "doesntmatch"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password doesn't match verification password")
  end

  it "should raise an error if password too short" do
    lambda {
      @brandon_signup_attributes[:password] = "Short"
      @brandon_signup_attributes[:password_verified] = "Short"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password must be at least 8 characters long")
  end

  it "should raise an error if password too simple" do
    lambda {
      @brandon_signup_attributes[:password] = "simplepassword"
      @brandon_signup_attributes[:password_verified] = "simplepassword"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password must contain both uppercase and lowercase letters")
  end

  it "should raise an error if email invalid" do
    lambda {
      @brandon_signup_attributes[:email] = "no.at.sign"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email invalid format")
  end

  it "should raise an error if a user with that name_key and password already exists" do
    User.signup!(@brandon_signup_attributes)
    lambda {
      @brandon_signup_attributes[:email] = "a@different.email"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Legal name and password already taken")
  end

  it "should raise an error if a user with that name_key and email_key already exists" do
    User.signup!(@brandon_signup_attributes)
    lambda {
      @brandon_signup_attributes[:password] = "PassWord2"
      @brandon_signup_attributes[:password_verified] = "PassWord2"
      @brandon_signup_attributes[:email] = "Brandon@TheSanders.us"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Legal name and email already taken")
  end

  it "should save the password as hashed text" do
    u = User.signup!(@brandon_signup_attributes)
    u.password.should eql("7005473cad87b5f62724520a823a6f5b42a16075")
  end

  it "signup should create and return a new user if none by that name/password already exists" do
    User.signup!(@brandon_signup_attributes).id.should eql(1)
  end
end

describe User, "login" do
  include UserSpecHelper

  before(:each) do
    User.signup!(brandon_signup_attributes)
    @brandon_login_attributes = brandon_signup_attributes
  end

  it "should raise an error unless given a password" do
    lambda {
      User.login({:name_or_email => 'Brandon CS Sanders'}).id.should eql(1)
    }.should raise_error(UserLoginException, "Password is missing")
  end

  it "should raise an error unless given an email or legal_name" do
    lambda {
      User.login({:password => 'Something'}).id.should eql(1)
    }.should raise_error(UserLoginException, "Name/email is missing")
  end

  it "should login a user given an existing legal_name and password" do
    User.login({:name_or_email => 'BrandonClarkSchoepflin Sanders', :password => "PassWord"}).id.should eql(1)
  end

  it "should login a user given an email and password" do
    User.login({:name_or_email => 'BRANDON@thesanders.us', :password => "PassWord"}).id.should eql(1)
  end

  it "should return nil given a non-existant legal_name/email and password" do
    User.login({:name_or_email => 'NonExistent', :password => "PassWord"}).should be_nil
  end
end
