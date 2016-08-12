class List < ActiveRecord::Base
  has_many :tasks

  def complete_all_tasks!
   tasks.update_all(complete: true)
  end

 def snooze_all_tasks!
   tasks.each{|task| task.snooze_hour!}
 end

 def total_duration
   tasks.map{|task| task.duration}.inject(:+)
 end

 def incomplete_tasks
  tasks.select{|task| task.complete == false}
 end

 def favorite_tasks
   tasks.select{|task| task.favorite == true}
 end
end
