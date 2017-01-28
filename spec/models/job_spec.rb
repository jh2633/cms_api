require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should belong_to(:category) }
  it { should have_and_belong_to_many(:keywords) }
end
