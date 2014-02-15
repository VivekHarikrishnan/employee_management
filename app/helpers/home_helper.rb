module HomeHelper
	def decide_selection_for(controller_name)
		"selected" if controller.controller_name == controller_name
	end
end
