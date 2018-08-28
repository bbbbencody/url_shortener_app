require 'rails_helper'

RSpec.describe Link, type: :model do

after(:all) do
	DatabaseCleaner.clean_with(:truncation)
end

	let(:link) {FactoryBot.create(:link)}

	describe 'expire!' do
		it 'sets expired field to true' do
			link.expire!
			expect(link.expired).to be true
		end
	end

	describe 'increment_uses!' do
		it 'adds one to the number of uses' do
			link.increment_uses!
			expect(link.uses).to eq(1)
		end
	end

end
