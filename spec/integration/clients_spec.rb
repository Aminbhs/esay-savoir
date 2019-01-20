require 'swagger_helper'

describe 'Clients API' do

  path '/api/v1/clients' do

    post 'Creates a client' do
      tags 'Clients'
      consumes 'application/json', 'application/xml'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          prenom: { type: :string },
          nom: { type: :string },
          num_rue: { type: :string },
          rue: { type: :string },
          codepostal: { type: :string },
          ville: { type: :string },
          telephone: { type: :string },
          email: { type: :string }
        },
        required: [ 'nom', 'email' ]
      }

      response '201', 'Client created' do
        let(:client) { { name: 'Dodo', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:client) { { nom: 'foo' } }
        run_test!
      end

      response '500', 'invalid request' do
        let(:client) { { nom: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/clients/{id}' do

    get 'Retrieves a client' do
      tags 'Clients'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            nom: { type: :string },
            prenom: { type: :string },
            num_rue: { type: :string },
            rue: { type: :string },
            codepostal: { type: :string },
            ville: { type: :string },
            telephone: { type: :string },
            email: { type: :string }
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { Client.create(nom: 'foo', email: 'bar', num_rue: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

    path '/api/v1/clients' do

    get 'Get all OR filters clients' do
      tags 'Clients'
      produces 'application/json', 'application/xml'

      parameter name: :id, in: :query, type: :integer, required: false
      parameter name: :prenom, in: :query, type: :string, required: false
      parameter name: :nom, in: :query, type: :string, required: false
      parameter name: :email, in: :query, type: :string, required: false

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            nom: { type: :string },
            prenom: { type: :string },
            num_rue: { type: :string },
            rue: { type: :string },
            codepostal: { type: :string },
            ville: { type: :string },
            telephone: { type: :string },
            email: { type: :string }
          },
          required: []

        let(:id) { Client.create(nom: 'foo', email: 'bar', num_rue: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/clients/{id}' do
    put 'Update a client' do
      tags 'Clients'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          prenom: { type: :string },
          nom: { type: :string },
          num_rue: { type: :string },
          rue: { type: :string },
          codepostal: { type: :string },
          ville: { type: :string },
          telephone: { type: :string },
          email: { type: :string }
        },
        required: [ 'nom', 'email' ]
      }

      response '201', 'Client updated' do
        let(:client) { { name: 'Dodo', status: 'available' } }
        run_test!
      end
      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/clients/{id}' do
    delete 'Delete a client' do
      tags 'Clients'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string


      response '201', 'Client deleted' do
        let(:client) { { name: 'Dodo', status: 'available' } }
        run_test!
      end
      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

    path '/api/v1/clients/get_clients_by_formation' do

    get 'Get clients by formation' do
      tags 'Clients'
      produces 'application/json', 'application/xml'
      parameter name: :formation_id, :in => :query, :type => :integer
      parameter name: :date_debut, :in => :query, :type => :string, required: false

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            nom: { type: :string },
            prenom: { type: :string },
            num_rue: { type: :string },
            rue: { type: :string },
            codepostal: { type: :string },
            ville: { type: :string },
            telephone: { type: :string },
            email: { type: :string }
          },
          required: [ 'id' ]

        let(:id) { Client.create(nom: 'foo', email: 'bar', num_rue: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end


end
