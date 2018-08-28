FactoryBot.define do 
	factory :link do
		url {'https://roosterteeth.com'}
		uses {0}
		expired {false}
	end

end