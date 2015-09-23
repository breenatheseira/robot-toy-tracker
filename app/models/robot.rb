class Robot < ActiveRecord::Base
	def reported_position(robot)
		robot.x_coordinate.blank? ? "Robot #{robot.name} is not placed on the table yet." : "#{robot.x_coordinate}, #{robot.y_coordinate}, #{robot.position}"
	end
end
