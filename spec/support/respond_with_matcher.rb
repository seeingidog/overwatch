RSpec::Matchers.define :respond_with do |code|
  match do |response|
    response.status == status
  end
  
  failure_message_for_should do |code|
    "expected to respond_with #{code}"
  end
  
  failure_message_for_should_not do |code|
    "expected to not respond with #{code}"
  end
  
  description do
    "respond with #{code}"
  end
end

RSpec::Matchers.define :have_body do |body|
  match do |response|
    response.body == body
  end
  
  failure_message_for_should do |body|
    "expected to have a body of #{body}"
  end
  
  failure_message_for_should_not do |body|
    "expected to not have a body of #{body}"
  end
  
  description do
    "have a valid response body"
  end
end