require 'swagger_helper'

describe 'Formations API' do

  path '/api/v1/formations' do

    post 'Creates a formation' do
      tags 'Formations'
      consumes 'application/json', 'application/xml'

      parameter name: :formation, in: :body, schema: {
        type: :object,
        properties: {
          nom: { type: :string, required: true },
          programme: { type: :string },
          date_debut: { type: :string },
          date_fin: { type: :datetime },
          nombre_place_total: { type: :integer },
          nombre_place_restante: { type: :integer }
        },
        required: [ 'nom', 'programme' ]
      }, description: "Date format : YYYY-MM-DD / Date example : 2019-12-30"

      response '201', 'Client created' do
        let(:formation) { { name: 'Dodo', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:formation) { { nom: 'foo', programme: 'bar' } }
        run_test!
      end
    end
  end

  path '/api/v1/formations/{id}' do

    get 'Retrieves a formation' do
      tags 'Formations'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            nom: { type: :string },
            programme: { type: :string },
            date_debut: { type: :date },
            date_fin: { type: :date },
            nombre_place_total: { type: :integer },
            nombre_place_restante: { type: :integer }
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { Formation.create(nom: 'foo', email: 'bar', num_rue: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'formation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

    path '/api/v1/formations' do

    get 'Get all OR filters formations' do
      tags 'Formations'
      produces 'application/json', 'application/xml'

      parameter name: :id, in: :query, type: :integer, required: false
      parameter name: :nom, in: :query, type: :string, required: false
      parameter name: :date_debut, in: :query, type: :date, required: false
      parameter name: :more_than_zero_place, in: :query, type: :boolean, required: false

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            nom: { type: :string },
            programme: { type: :string },
            date_debut: { type: :date },
            date_fin: { type: :date },
            nombre_place_total: { type: :integer },
            nombre_place_restante: { type: :integer }
          },
          required: []

        let(:id) { Formation.create(nom: 'foo', email: 'bar', num_rue: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'formation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/formations/{id}' do
    put 'Update a formation' do
      tags 'Formations'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      parameter name: :formation, in: :body, schema: {
        type: :object,
        properties: {
          nom: { type: :string },
          programme: { type: :string },
          date_debut: { type: :date },
          date_fin: { type: :date },
          nombre_place_total: { type: :integer },
          nombre_place_restante: { type: :integer }
        },
        required: [ 'nom', 'email' ]
      }

      response '201', 'Client updated' do
        let(:formation) { { name: 'Dodo', status: 'available' } }
        run_test!
      end
      response '404', 'formation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/formations/{id}' do
    delete 'Delete a formation' do
      tags 'Formations'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string


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
