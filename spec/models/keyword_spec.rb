require 'rails_helper'

RSpec.describe Keyword, type: :model do
  it { should have_and_belong_to_many(:jobs) }
end
