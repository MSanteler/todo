require 'rails_helper'

RSpec.describe Tasklet, type: :model do

  it { should belong_to(:task) }
  it { should belong_to(:subtask).class_name('Task') }

end
