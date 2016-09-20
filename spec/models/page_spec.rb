require 'rails_helper'

RSpec.describe Page, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:tags) }
  end

end
