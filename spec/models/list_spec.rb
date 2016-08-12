require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'marks all tasks from the list as complete' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name: "Take out the trash")
      Task.create(complete: false, list_id: list.id, name: "play the drums")
      Task.create(complete: false, list_id: list.id, name: "have a beer")
      list.complete_all_tasks!
      list.tasks.each do |task|
      expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'delays all tasks for one hour' do
      time = Time.now
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name: "Take out the trash", deadline: time )
      Task.create(complete: false, list_id: list.id, name: "play the drums", deadline: time )
      Task.create(complete: false, list_id: list.id, name: "have a beer", deadline: time)
      list.snooze_all_tasks!
      list.tasks.each do |task|
      expect(task.deadline).to eq(time + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'adds the duration of all the tasks' do
      list = List.create(name: "Chores")
      Task.create(duration: 30, list_id: list.id, name: "Take out the trash" )
      Task.create(duration: 20, list_id: list.id, name: "play the drums" )
      Task.create(duration: 100, list_id: list.id, name: "have a beer")
      list.total_duration
      total_duration = 0
      list.tasks.each do |task|
      total_duration += task.duration
      end
      expect(list.total_duration).to eq(total_duration)
      #alternatively expect(list.total_duration).to eq(150)
    end
  end

  describe '#incomplete_tasks' do
    it 'returns an array of unfinished tasks' do
      list = List.create(name: "Chores")
      one =  Task.create(complete: false, list_id: list.id, name: "Take out the trash" )
      two = Task.create(complete: false, list_id: list.id, name: "play the drums")
      three = Task.create(complete: true, list_id: list.id, name: "have a beer")
      list.incomplete_tasks
      expect(list.incomplete_tasks).to match_array([one, two])
    end
  end

  describe '#favorite_tasks' do
    it 'returns an array of unfinished tasks' do
      list = List.create(name: "Chores")
      one =  Task.create(favorite: true, list_id: list.id, name: "Take out the trash" )
      two = Task.create(favorite: true, list_id: list.id, name: "play the drums")
      three = Task.create(favorite: false, list_id: list.id, name: "have a beer")
      list.favorite_tasks
      expect(list.favorite_tasks).to match_array([one, two])
    end
  end
end
