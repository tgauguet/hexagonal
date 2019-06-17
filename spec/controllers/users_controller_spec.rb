require 'spec_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #dashboard' do

    it 'render :dashboard view' do
      get :dashboard
      response.should render_template :dashboard
    end

  end

end
