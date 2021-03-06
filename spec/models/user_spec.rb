#you must run 'rake testprep' before you run these specs otherwise the ones needing access to the test db will fail
require 'spec_helper'

$db = SQLite3::Database.open 'user_testing.db'

describe User do

	context 'Initialization of new user object' do

		it 'should be initialized with a first name' do
			tyson = User.new({:first_name=> 'Tyson'})
			tyson.first_name.should eq ('Tyson')
		end

		it 'should be initialized with a last name' do
			tyson = User.new({:last_name=> 'Kunovsky'})
			tyson.last_name.should eq ('Kunovsky')
		end

		it 'should be initialized with an email address' do
			tyson = User.new({:email=> 'tyson@test.com'})
			tyson.email.should eq ('tyson@test.com')
		end

		it 'should be initialized with a phone number' do
			tyson = User.new({:phone=> '206-240-1332'})
			tyson.phone.should eq ('206-240-1332')
		end

		it 'should be initialized with created at date' do
			tyson = User.new({:created_at=> '2013-04-17T11:36:58-07:00'})
			tyson.created_at.should eq ('2013-04-17T11:36:58-07:00')
		end
	end

	context 'Assingment of attributes' do

		it 'should not allow for assignment of first_name' do
			tyson = User.new(:first_name => "Tyson")
			expect {tyson.first_name = "Jake"}.to raise_error
		end

		it 'should not allow for assignment of last_name' do
			tyson = User.new(:last_name => "Kunovsky")
			expect {tyson.last_name = "James"}.to raise_error
		end

		it 'should not allow for assignment of email' do
			tyson = User.new(:email => "test@yahoo.com")
			expect {tyson.email = "test@gmail.com"}.to raise_error
		end

		it 'should not allow for assignment of phone number' do
			tyson = User.new(:phone => "206-240-1332")
			expect {tyson.phone = "206-240-1333"}.to raise_error
		end

		it 'should not allow for assignment of created_at' do
			tyson = User.new(:created_at => "2013-04-17T11:36:58-07:00")
			expect {tyson.created_at = "2013-04-17T11:36:58-07:01"}.to raise_error
		end
	end

	context 'Class methods' do

		context "self.sort_by_first_name" do

			it 'should list all users by first name alphabetically' do
				all_users = User.sorted_by_first_name
				all_users[0][1].should be <= all_users[1][1]
			end
		end

		context "self.sort_by_last_name" do

			it 'should list all users by last name alphabetically' do
				all_users = User.sorted_by_last_name
				all_users[0][2].should be <= all_users[1][2]
			end
		end

		context 'self.sorted_by_created_at' do

			it 'should list all users by created at with earlier created users coming first' do
				all_users = User.sorted_by_created_at
				all_users[0][5].should be <= all_users[1][5]
			end
		end

		context 'self.where(attribute,value)' do

			it 'should allow you to select users by their attributes using the self.where method' do
				expect {User.where("id = ?", 1)}.not_to be_nil
			end
		end
	end

	context 'Instance methods' do

		context 'save' do

# this test also ensures that the database was created correctly
			it 'should not allow you to save a user that has missing attributes' do
				tyson = User.new({:first_name => "Tyson",
					:last_name => "Kunovsky",
					:email => "tkunovsky@email.com",
					:phone => "206-240-1332"})
				expect {tyson.save}.to raise_error
			end

# this test also ensures that the database was created correctly
			it 'should allow you to save a user that has all the required attribues' do
				tyson = User.new({:first_name => "Tyson",
					:last_name => "Kunovsky",
					:email => "#{rand(1..1000)}tkunovsky#{rand(1..1000)}@email.com",
					:phone => "206-240-1332",
					:created_at => "2013-04-17T11:36:58-07:00"})
				expect {tyson.save}.not_to raise_error
			end
		end
	end
end