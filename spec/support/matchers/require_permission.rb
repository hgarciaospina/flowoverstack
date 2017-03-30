RSpec::Matchers.define :require_permission do |expected|
  match do |actual|
    expect(actual).to redirect_to Rails.application.routes.url_helpers.questions_path 
  end

  failure_message do |actual|
    "expected to require permission to access the question"
  end

  failure_message_when_negated do |actual|
    "expected not to require permission to access the question"
  end

  description do
    "redirect to the questions path"
  end
end