require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  def run_test_with_options(options)
    if options[:auth] == true
      # run without authenticated user
      logout
      yield false
      
      if options[:owner] == true
        # run with unauthorized user
        login_as @unauthnticated_user
        yield false
        logout
        
        # run with authorized user
        login_as @authenticated_user
        yield true
        logout
      else
        # run with authorized user
        login_as @authenticated_user
        yield true
        logout

        # run with unauthorized user
        login_as @unauthnticated_user
        yield true
        logout
      end
    else
      # run without authenticated user
      logout
      yield true
      
      # run with unauthorized user
      login_as @unauthnticated_user
      yield true
      logout
      
      # run with authorized user
      login_as @authenticated_user
      yield true
      logout
    end
    
  end
end