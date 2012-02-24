module MatchersHelper
  RSpec::Matchers.define :have_error_message do |message|
    match do |page|
      page.should have_selector('div.flash.alert-error', text: message)
    end
  end

  RSpec::Matchers.define :have_success_message do |message|
    match do |page|
      page.should have_selector('div.flash.alert-success', text: message)
    end
  end

  RSpec::Matchers.define :have_heading do |text|
    match do |page|
      page.should have_selector('h1',    text: text)
    end
  end

  RSpec::Matchers.define :have_title do |text|
    match do |page|
      page.should have_selector('title', text: text)
    end
  end
end