require 'spec_helper'

describe User do
	let(:workplace) { Workplace.make! }

	describe "class methods" do 

		describe "create_with_roles" do

			context "when the user is created successfully" do
				let(:user_params) { { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email } }
				let(:valid_args) { { workplace: workplace, user_params: user_params, role_ids: [] } }

				it "should add the user to the workplace" do
					User.create_with_roles valid_args
					workplace.users.where("users.email = ?", user_params[:email]).should be_present
				end

				it "should create an EmployeeRole between the user and workplace" do
					result = User.create_with_roles valid_args
					user = result[:user]
					user.roles.employee.where("roles.workplace_id = ?", workplace.id).size.should eq 1
				end

				it "should return a hash with success" do 
					result = User.create_with_roles valid_args
					result[:success].should be_present
				end

				context "when the args contain role_ids to add to the user" do
					let(:manager_role) { Role.make!(workplace: workplace, name: "Manager") }
					let(:barmen_role) { Role.make!(workplace: workplace, name: "Barman") }
					let(:args_with_roles) { 
						valid_args[:role_ids] = [manager_role.id, barmen_role.id]
						valid_args
					}

					it "should add the roles to the user" do 
						result = User.create_with_roles args_with_roles
						user = result[:user]
						user.roles.by_workplace(workplace).map(&:name).should include(manager_role.name, barmen_role.name)
					end
				end
			end

			context "when the user creation rollsback" do
				let(:invalid_args) { { workplace: workplace, user: nil, role_ids: [] } }

				it "should not create the user" do
					user_count = User.all.size
					User.create_with_roles invalid_args
					User.all.size.should eq user_count
				end

				it "should not add the user to the workplace" do
					User.create_with_roles invalid_args
					workplace.users.should be_empty
				end

				it "should not create any Employment models" do
					User.create_with_roles invalid_args
					workplace.employments.should be_empty
				end

				it "should return a hash with 'msg' and 'user'" do
					result = User.create_with_roles invalid_args
					result.keys.should include(:msg, :user)
				end
			end
		end

		describe "update_with_roles" do


			context "when the user update succeed" do

				context "when the roles update succeed" do

				end

				context "when the roles update fails" do

				end
			end

			context "when the user update fails" do

			end
		end
	end
end