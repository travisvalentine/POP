require 'spec_helper'

describe Widget do
  let(:widget) { FactoryGirl.create(:widget) }

  before(:each) do
    widget
  end

  describe "embed code" do
    it "returns the correct embed string" do
      widget.embed_code.should == "<script type='text/javascript' src='http://#{RAW_URL}/embeds/#{widget.id}.js'></script>"
    end
  end
end
