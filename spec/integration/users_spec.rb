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
        end.should change(User, :count).by(2)
      end
    end
  end
end
