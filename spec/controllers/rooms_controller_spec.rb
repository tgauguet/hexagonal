require 'spec_helper'

RSpec.describe RoomsController, type: :controller do

  describe 'GET #index' do

    it 'render :index view' do
      get :index
      response.should render_template :index
    end

  end

end
