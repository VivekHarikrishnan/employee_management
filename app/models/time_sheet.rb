class TimeSheet < ActiveRecord::Base
	default_scope :order => "date_of_sheet DESC, to_time DESC"

	belongs_to :employees_projects
	belongs_to :project_task
	validates :employees_projects_id, :presence => true
	validates :date_of_sheet, :presence => true
	validates :project_task_id, :presence => true
	validates :from_time, :presence => true
	validates :to_time, :presence => true, :uniqueness => { :scope => [:employees_projects_id, :project_task_id, :date_of_sheet, :from_time] }

	validate :from_time_less_than_to_time, :time_entries

	FULL_TIME_MAX_WORKING_HOURS = 9
	PART_TIME_MAX_WORKING_HOURS = 4
	
	def employee
		employees_projects.employee if employees_projects
	end

	def employee_id
		employee.id if employee
	end

	def project
		employees_projects.project if employees_projects
	end

	def project_id
		project.id if project
	end	

	def total_hours
		hours(total_seconds) == 0 ? "#{minutes(total_seconds)} minute(s)" : (minutes(total_seconds) == 0 ? "#{hours(total_seconds)} hour(s)" : "#{hours(total_seconds)} hour(s) #{minutes(total_seconds)} minute(s)")
	end

	def total_seconds
		to_time - from_time
	end

	def from_time_less_than_to_time
		errors.add(:from_time, "must be less than to time") if from_time && to_time && (to_time <= from_time)
	end

	def time_entries
		if project
			max_hour = project.type == "FullTimeProject" ? FULL_TIME_MAX_WORKING_HOURS : PART_TIME_MAX_WORKING_HOURS
			errors.add(:to_time, "must be less than maximum working hours #{max_hour}") if (hours(total_seconds) > max_hour)
			if employee
				if Rails.env != "production"
					existing_entries_millis = employee.time_sheets.select("SUM(to_time-from_time) as time_millis").group("date_of_sheet").map(&:time_millis).first
				else
					existing_entries_millis = employee.time_sheets.select("SUM(to_time-from_time) as time_millis").group("date_of_sheet, to_time, from_time").map(&:time_millis).first
				end
				if existing_entries_millis
					existing_entries_time = existing_entries_millis / 10000.0
					if from_time && to_time
						cur_hour = hours(to_time - from_time)
						cur_min = minutes(to_time - from_time)
						cur_time = cur_hour + (cur_min/10.0)
						errors.add(:to_time, "must be less than maximum working hours #{max_hour}. Already entered for #{existing_entries_time} hours. Current entry is #{cur_time} hours") if (existing_entries_time + cur_time) > max_hour
					end
				end
			end
		end
	end

	private
	def convert_time(time)
		mm, ss = time.divmod 60
		hh, mm = mm.divmod 60

		[hh, mm]
	end

	def hours(time)
		convert_time(time).first
	end

	def minutes(time)
		convert_time(time).last
	end
end
