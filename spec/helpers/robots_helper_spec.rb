require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RobotsHelper. For example:
#
# describe RobotsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RobotsHelper, type: :helper do
  let (:robot) { build(:robot) }
  let (:direction_array) { ["NORTH","EAST","SOUTH","WEST"] }
  let (:position_array) { [0,90,180,270] }

  describe ".get_report(robot)" do
  	context "display when robot's position.nil?" do
  		it { expect(get_report(robot)).to include("is not placed on the table") }
  	end

  	context "display when robot's has a position" do
  		let(:robot) { build(:robot, position: position_array.sample, x_coordinate: 1, y_coordinate: 1) }
  		let (:position_index) { position_array.index(robot.position) }
  		it { expect(get_report(robot)).to eq("#{robot.x_coordinate},#{robot.y_coordinate},#{direction_array.at(position_index)}") }
  	end
  end
end
