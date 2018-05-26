RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.before :each do
    # Create Users
    @user1 = User.create!(role: 1, username: 'user1', password: 'user1spassword', address: '111 Not An Address', first_name: 'User', last_name: 'One')
    @user2 = User.create!(role: 0, username: 'user2', password: 'user2spassword', address: '222 Not An Address', first_name: 'User', last_name: 'Two')
    @user3 = User.create!(role: 0, username: 'user3', password: 'user3spassword', address: '333 Not An Address', first_name: 'User', last_name: 'Three')
    @user4 = User.create!(role: 0, username: 'user4', password: 'user4spassword', address: '444 Not An Address', first_name: 'User', last_name: 'Four')
  end
end
