require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  include Devise::TestHelpers
  login_user

  describe 'GET #index' do
    it 'Should render :index view' do
      get :index
      response.should render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new booking' do
        FactoryBot.create(:room)
        booking_params = FactoryBot.attributes_for(:booking, room_ids: { '1'=>'1' })
        expect { post :create, params: { booking: booking_params } }.to change(Booking, :count).by(1)
      end
      it 'redirect to bookings#index' do
        booking_params = FactoryBot.attributes_for(:booking, room_ids: { '1'=>'1' })
        post :create, params: { booking: booking_params }
        response.should redirect_to('/bookings')
      end
    end
    context 'with invalid attributes' do
      it 'does not create a new booking' do
        booking_params = FactoryBot.attributes_for(:booking, start: nil, room_ids: { '1'=>'1' })
        expect { post :create, params: { booking: booking_params } }.to change(Booking, :count).by(0)
      end
      it 'redirect to rooms#index' do
        booking_params = FactoryBot.attributes_for(:booking, start: nil, room_ids: { '1'=>'1' })
        post :create, params: { booking: booking_params }
        response.should redirect_to :root
      end
    end
  end

  describe 'POST #destroy' do
    context 'with valid attributes' do
      it 'destroy a booking' do
        FactoryBot.create(:room)
        booking_params = FactoryBot.attributes_for(:booking, room_ids: { '1'=>'1' })
        post :create, params: { booking: booking_params }
        expect { delete :destroy, params: { id: Booking.last.id } }.to change(Booking, :count).by(-1)
      end
    end
    context 'with invalid attributes' do
      it 'fail to destroy a booking' do

      end
    end
    it 'redirect to rooms#index' do

    end
  end

end
