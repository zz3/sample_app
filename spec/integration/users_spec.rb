require 'spec_helper'

describe "Users" do
 
  describe "signup" do
    describe "failure" do
      it "sollte keinen neuen User anlegen" do
        lambda do
          visit signup_path
          click_button
          response.should render_template('new')
          response.should have_tag("div#errorExplanation")
        end.should_not change(User, :count)
      end
    end
    describe "success" do
      it "sollte einen neuen User anlegen" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Ein Oed"
          fill_in "Email",        :with => "ein@oed.de"
          fill_in "Password",     :with => "einsgeheim"
          fill_in "Confirmation", :with => "einsgeheim"
          click_button
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "login/logout" do
    describe "Fehlschlag" do
      it "sollte einen User nicht einloggen" do
        visit login_path
        fill_in "Email",    :with => ""
        fill_in "Password", :with => ""
        click_button
        response.should render_template("sessions/new")
        response.should have_tag("div.flash.error", /Ungültige Kombination/i)
      end
    end
    describe "Erfolg" do
      it "sollte einen User einloggen" do
        user = Factory(:user)
        visit login_path
        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password
        click_button
        controller.signed_in?.should == true 
        click_link "Logout"
        controller.signed_in?.should == false
      end
    end
  end
  
end
