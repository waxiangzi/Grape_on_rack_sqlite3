require 'spec_helper'

describe User do

	context 'Initialization and attribute assignment' do

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

		it 'should list all users by first name alphabetically' do
			all_users = User.sorted_by_first_name
			all_users[0][1].should be <= all_users[1][1]
		end

		it 'should list all users by last name alphabetically' do
			all_users = User.sorted_by_last_name
			all_users[0][1].should be <= all_users[1][1]
		end

	end
end