require 'spec_helper'

describe "Static pages" do

  let(:sample_app_text) {"Ruby on Rails Tutorial Sample App"}

  describe "Home page" do

    it "should have the h1 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title("#{sample_app_text}")
    end

    it "should not have '|Home'" do
      visit '/static_pages/home'
      expect(page).not_to have_title("| Home")
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("#{sample_app_text} | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("#{sample_app_text} | About Us")
    end
  end

  describe "Contact page" do
    it "should have the h1 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_content("Contact Us")
    end

    it "should have the title 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_title("#{sample_app_text} | Contact Us")
    end
  end
end