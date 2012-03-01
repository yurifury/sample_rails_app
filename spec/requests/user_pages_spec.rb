require 'spec_helper'
include MatchersHelper

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { create(:user) }
    before { visit user_path(user) }

    it { should have_heading(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_heading('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button 'Sign up' }.not_to change(User, :count)
      end
    end

    describe "error messages" do
      before { click_button 'Sign up' }

      let(:error) { 'errors prohibited this user from being saved' }

      it { should have_title('Sign up') }
      it { should have_content(error) }
    end

    describe "with valid information" do
      before do
        fill_in 'Name',         with: 'Example User'
        fill_in 'Email',        with: 'user@example.com'
        fill_in 'Password',     with: 'foobar'
        fill_in 'Confirmation', with: 'foobar'
      end

      it "should create a user" do
        expect { click_button 'Sign up' }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button 'Sign up' }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title(user.name) }
        it { should have_success_message('Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:user) { create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_heading('Edit user') }
      it { should have_title('Edit user') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      let(:error) { '1 error prohibited this user from being saved' }
      before { click_button 'Update'}

      it { should have_content(error) }
    end

    describe "with valid information" do
      let(:user)      { create(:user) }
      let(:new_name)  { 'New Name' }
      let(:new_email) { 'new@example.com' }
      before do
        fill_in 'Name',         with: new_name
        fill_in 'Email',        with: new_email
        fill_in 'Password',     with: user.password
        fill_in 'Confirmation', with: user.password
        click_button 'Update'
      end

      it { should have_title(new_name) }
      it { should have_success_message }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }

    end
  end

  describe "index" do

    let(:user) { create(:user) }
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }

    describe "pagination" do
      before(:all) { 30.times { create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('Next') }
      it { should have_link('2') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete')}.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
end