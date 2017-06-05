require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

    ####### DOWNGRADE #######
    describe "downgrade from premium to standard" do
      downgrade_premium_to_standard

      it "should change the role from premium to standard" do
        expect(subject.current_user.role).to eq('standard')
      end
    end
end
