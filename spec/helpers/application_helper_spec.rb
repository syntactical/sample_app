require 'spec_helper'

describe ApplicationHelper do
  describe "full_title" do
    it "should return sample app text if no title given" do
      expect(full_title).to match(/^Ruby on Rails Tutorial Sample App/)
    end

    it "should not have a '|' if no title given" do
      expect(full_title).not_to match(/\|/)
    end

    it "should include title if title given" do
      expect(full_title("greg")).to match(/greg/)
    end
  end
end