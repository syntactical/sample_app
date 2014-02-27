require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "example@text.net",
                            password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when user name is blank" do
    before { @user.name = "" }

    it { should_not be_valid }
  end

  describe "when user name is more than 50 characters" do
    before { @user.name = "X" * 51 }

    it { should_not be_valid }
  end

  describe "when user email is blank" do
    before { @user.email = "" }

    it { should_not be_valid }
  end

  describe "when user email is improperly formatted" do
    it "should be invalid" do
      invalid_email_addresses = %w[x@x,com sio_at_com.net
                                  ee.ss%@d.com xe2@m+m.net]
      invalid_email_addresses.each do |address|
        @user.email = address

        expect(@user).not_to be_valid
      end
    end
  end

  describe "when user email is properly formatted" do
    it "should be valid" do
      email_addresses = %w[x@x.com sio@com.net.au
                                  ee.ss@d.com 2_22+2@m.net]
      email_addresses.each do |address|
        @user.email = address

        expect(@user).to be_valid
      end
    end
  end

  describe "when an email address is already taken" do
    before do
      user_duplicate = @user.dup
      user_duplicate.email = @user.email.upcase
      user_duplicate.save
    end

    it { should_not be_valid }
  end

  describe "when password is blank" do
    before { @user = User.new(name: "Example User", email: "example@text.net",
                              password: "", password_confirmation: "") }
    it { should_not be_valid }
  end

  describe "when the password is too short" do
    before {@user.password = @user.password_confirmation = "X" * 5}
    it {should_not be_valid}
  end

  describe "when password confirmation does not match password" do
    before { @user.password_confirmation = "wrong" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("Invalid Password") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
