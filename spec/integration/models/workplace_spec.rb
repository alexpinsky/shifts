require 'spec_helper'

describe Workplace do
	let(:workplace) { Workplace.make! }

	describe "after creation" do
		
		describe "default roles" do
			subject(:default_roles) { workplace.roles.map(&:type) }
			it { should include('AdminRole', 'EmployeeRole') }
		end
	end
end