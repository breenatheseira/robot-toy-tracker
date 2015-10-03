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
	let (:direction_array) { ["NORTH","EAST","SOUTH","WEST"] }
	let (:position_array) { [0,90,180,270] }
	let(:robot) { build(:robot, position: position_array.sample, x_coordinate: 1, y_coordinate: 1) }
	let (:position_index) { position_array.index(robot.position) } 

	describe ".get_report(robot)" do
		context "display when robot's position.nil?" do
			let(:robot) { build(:robot) }
			it { expect(get_report(robot)).to include("is not placed on the table") }
		end

		context "display when robot's has a position" do
			let (:position_index) { position_array.index(robot.position) }
			it { expect(get_report(robot)).to eq("#{robot.x_coordinate},#{robot.y_coordinate},#{direction_array.at(position_index)}") }
		end
	end

	describe ".set_left" do
		context "when Robot's position is 0" do
			it "returns 270" do
				robot.position = 0
				expect(set_left(robot)).to eq(270)
			end
		end

		context "when Robot's position is 90" do
			it "returns 0" do
				robot.position = 90
				expect(set_left(robot)).to eq(0)
			end
		end

		context "when Robot's position is 180" do
			it "returns 90" do
				robot.position = 180
				expect(set_left(robot)).to eq(90)
			end
		end

		context "when Robot's position is 270" do
			it "returns 180" do
				robot.position = 270
				expect(set_left(robot)).to eq(180)
			end
		end
	end

	describe ".set_right" do
		context "when Robot's position is 0" do
			it "returns 90" do
				robot.position = 0
				expect(set_right(robot)).to eq(90)
			end
		end

		context "when Robot's position is 90" do
			it "returns 180" do
				robot.position = 90
				expect(set_right(robot)).to eq(180)
			end
		end

		context "when Robot's position is 180" do
			it "returns 270" do
				robot.position = 180
				expect(set_right(robot)).to eq(270)
			end
		end

		context "when Robot's position is 270" do
			it "returns 0" do
				robot.position = 270
				expect(set_right(robot)).to eq(0)
			end
		end
	end

	describe ".set_move" do
		context "when robot's position is 0" do
			for i in 0..4
				context "and y_coordinate < #{i}" do
					let(:robot) { build(:robot, position: 0, x_coordinate: 1, y_coordinate: i) }
					it "returns y_coordinate to #{i+1}" do
						expect(set_move(robot)).to eq(i+1)
					end
				end
			end

			context "and y_coordinate > 4" do
				let(:robot) { build(:robot, position: 0, x_coordinate: 1, y_coordinate: 5) }
				it "returns nil" do
					expect(set_move(robot)).to be_falsey
				end
			end
		end
	end
end