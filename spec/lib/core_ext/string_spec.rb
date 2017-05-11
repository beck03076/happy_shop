require 'rails_helper'

RSpec.describe String do
  describe '.to_cents' do
    it 'converts string to cents' do
      expect('18.99'.to_cents).to eq(1899)
    end
  end
end
