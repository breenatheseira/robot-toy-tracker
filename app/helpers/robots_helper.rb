module RobotsHelper
	def transform_command_to_movement(robot,command)
		command = command.upcase

		command = command.gsub(/ , /, ',')
		command = command.gsub(/, /, ',')
		command = command.gsub(/ ,/, ',')
		command = command.gsub(/PLACE /, 'PLACE_')

		# All the commands are split here
		command_array = command.split

		for element in command_array
			case element
			when "MOVE"
				set_move(robot)
			when "LEFT" 
				set_left(robot)
			when "RIGHT"
				set_right(robot)
			else
				if element.include? "PLACE"
				end
			end

			unless robot.position.nil?
				robot.update_attributes(position: robot.position, x_coordinate: robot.x_coordinate, y_coordinate: robot.y_coordinate)
			end
		end
	end

	def set_place (robot, string)

	end

	def set_left (robot)
		robot.position == 0 ? robot.position = 270 : robot.position -= 90
	end

	def set_right (robot)
		robot.position == 270 ? robot.position = 0 : robot.position += 90
	end

	def set_move (robot)
		case robot.position
		when 0
			robot.y_coordinate += 1 if robot.y_coordinate < 5
		when 90
			robot.x_coordinate += 1 if robot.x_coordinate < 5
		when 180
			robot.y_coordinate -= 1 if robot.y_coordinate > 0
		when 270
			robot.x_coordinate -= 1 if robot.x_coordinate > 0
	end
end
