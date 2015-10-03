require 'rails_helper'

RSpec.describe RobotsController, type: :controller do
	context "when there is no robots" do
		let(:robot) { Robot.clear }
		before { get :index }
				
		it { is_expected.to redirect_to(action: :new) }
	end
end
