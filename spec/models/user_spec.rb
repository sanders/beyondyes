require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :legal_name => "Brandon Clark Schoepflin Sanders",
      :password => User.hash_of_text("password"),

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