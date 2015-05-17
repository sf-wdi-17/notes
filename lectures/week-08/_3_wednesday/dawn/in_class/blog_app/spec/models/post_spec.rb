require 'rails_helper'

RSpec.describe Post, type: :model do
  # Make sure we have a valid factory

	before do
		@post = build(:post)
	end

	it 'has a valid factory' do
		expect(@post).to be_valid
	end

	it 'has the correct class type' do
		expect(@post).to eql Post.new
	end

	it 'must have a title' do
		@post.title = ""
		expect(@post).to be_valid
	end

	it 'has a method called add' do
		expect(@post).to respond_to 'add'
	end
end
