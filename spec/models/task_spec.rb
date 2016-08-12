require 'rails_helper'



RSpec.describe Task, type: :model do

  describe '#toggle_complete!' do
    it 'switches complete to false if it began at true' do
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
    it 'switches complete to true if it began at false' do
      task = Task.new(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'switches favorite to false if it began at true' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
    it 'switches favorite to true if it began at false' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?' do
    it 'returns true if a task is overdue' do
      task = Task.new(deadline: Time.now)
      task.overdue?
      expect(task.overdue?).to eq(true)
    end
    it 'returns false if a task is not overdue' do
      task = Task.new(deadline: Time.now + 1.hour)
      task.overdue?
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'adds 1 to priority if priority is less than 10' do
      task = Task.new(priority: 7)
      task.increment_priority!
      expect(task.priority).to eq(8)
    end
    it 'does not add 1 to priority if priority is more than 10' do
      task = Task.new(priority: 15)
      task.increment_priority!
      expect(task.priority).to eq(15)
    end
  end

  describe '#decrement_priority!' do
    it 'subtracts 1 from priority if priority is greater than 1' do
      task = Task.new(priority: 7)
      task.decrement_priority!
      expect(task[:priority]).to eq(6)
    end
    it 'does not subtract 1 from priority if priority is less than 1' do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task[:priority]).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should increase a deadline by 1 hour' do
      task = Task.new(deadline: Time.local(2016,"aug",10,20,15))
      task.snooze_hour!
      expect(task.deadline).to eq(Time.local(2016,"aug",10,20,15)  + 1.hour)
    end
  end

end
