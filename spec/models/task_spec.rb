require 'rails_helper'

RSpec.describe Task, type: :model do

  it { should belong_to(:user) }
  it { should have_many(:tasklets) }
  it { should have_many(:subtasks).through(:tasklets) }

end