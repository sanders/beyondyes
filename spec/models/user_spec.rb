require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :legal_name => "Brandon Clark Schoepflin Sanders",
      :name_key => "brandonclarkschoepflinsanders",
      :password => User.hash_of_text("PassWord"),

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

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end

describe User, "signup" do
  before(:each) do
    @brandon_signup_attributes = {
      :legal_name => "Brandon Clark Schoepflin Sanders",
      :password => "PassWord",
      :password_verified => "PassWord",
      :email => "brandon@thesanders.us"
    }
  end

  it "should raise an error if passwords don't match" do
    lambda {
      @brandon_signup_attributes[:password_verified] = "doesntmatch"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(UserSignupException, "passwords don't match")
  end

  it "should raise an error if password too short" do
    lambda {
      @brandon_signup_attributes[:password] = "short"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(UserSignupException, "password must be at least 8 characters long")
  end

  it "should raise an error if password too simple" do
    lambda {
      @brandon_signup_attributes[:password] = "simplepassword"
      @brandon_signup_attributes[:password_verified] = "simplepassword"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(UserSignupException, "password must contain both uppercase and lowercase letters")
  end

  it "should raise an error if email invalid" do
    lambda {
      @brandon_signup_attributes[:email] = "no.at.sign"
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(UserSignupException, "invalid email format")
  end

  it "should raise an error if a user with that name_key and password already exists" do
    User.signup!(@brandon_signup_attributes)
    @brandon_signup_attributes[:password_verified] = "PassWord"
    lambda {
      User.signup!(@brandon_signup_attributes)
    }.should raise_error(UserSignupException, "there is already a user with that name/password combination")
  end

  it "signup should create and return a new user if none by that name/password already exists" do
    User.signup!(@brandon_signup_attributes).id.should eql(1)
  end
end
