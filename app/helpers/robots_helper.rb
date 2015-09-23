module RobotsHelper

	def transform_command_to_movement(robot,command)
		command = command.upcase

		command = command.gsub(/ , /, ',')
		command = command.gsub(/, /, ',')
		command = command.gsub(/ ,/, ',')
		command = command.gsub(/PLACE /, 'PLACE_')

		# All the commands are split here
		command_array = command.split

		logger.info "command array: #{command_array}"

		for element in command_array
			should_update_robot = true

			case element
			when "MOVE"
				set_move(robot)
			when "LEFT" 
				set_left(robot)
			when "RIGHT"
				set_right(robot)
			else
				if element.include? "PLACE"
					set_place(robot, element)
				end
				should_update_robot = false
			end		
				
			update_robot(robot) if should_update_robot
		end
	end

	def update_robot(robot)
		unless robot.position.nil?
			robot.update_attributes(position: robot.position, x_coordinate: robot.x_coordinate, y_coordinate: robot.y_coordinate)
		end
	end

	def set_arrays
		Array @direction_array = Array.new
		Array @position_array = Array.new
		@direction_array = ["NORTH","EAST","SOUTH","WEST"]
		@position_array = [0,90,180,270]
	end

	def set_place (robot, string)
		set_arrays

		string_array = string[6..-1].split(',')		

		logger.info "string_array: #{string_array}"

		robot.x_coordinate = string_array.at(0)
		robot.y_coordinate = string_array.at(1)

		index = @direction_array.index(string_array.at(2))

		robot.position = @position_array.at(index)
		robot.update_attributes(position: robot.position, x_coordinate: robot.x_coordinate, y_coordinate: robot.y_coordinate)
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

	def get_report(robot)
		unless robot.position.nil?
			set_arrays
			index = @position_array.index(robot.position)
			report = "#{robot.x_coordinate},#{robot.y_coordinate},#{@direction_array.at(index)}"
		else
			report = "Robot #{robot.name} is not placed on the table yet."
		end
	end
end

