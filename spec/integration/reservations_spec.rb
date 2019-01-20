require 'swagger_helper'

describe 'Reservations API' do

  path '/api/v1/reservations' do

    post 'Creates a reservation' do
      tags 'Reservations'
      consumes 'application/json', 'application/xml'

      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          formation_id: { type: :integer },
          client_id: { type: :integer }
        },
      }, description: ""

      response '201', 'Reservation created' do
        let(:reservation) { { name: 'Dodo', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:reservation) { { nom: 'foo', programme: 'bar' } }
        run_test!
      end
    end
  end

  path '/api/v1/reservations/delete_by_client_and_formation_id' do
    delete 'Delete a reservation' do
      tags 'Reservations'
      produces 'application/json', 'application/xml'
      parameter name: :formation_id, :in => :query, :type => :integer
      parameter name: :client_id, :in => :query, :type => :integer

      response '201', 'Formation deleted' do
        let(:formation) { { name: 'Dodo', status: 'available' } }
        run_test!
      end
      response '404', 'formation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
