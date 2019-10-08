# spec/integration/pets_spec.rb
require 'swagger_helper'

describe 'Students API' do

  path '/students' do

    post 'Creates a student' do
      tags 'Studnets'
      consumes 'application/json'
      parameter name: :student, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'Student created' do
        let(:student) { { name: 'Aris', email: 'asdfas3242', password: 'dfssasdsf3242' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:student) { { email: 'foo' } }
        run_test!
      end
    end
  end

  path '/students/{id}' do

    get 'Retrieves a student' do
      tags 'Students'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            email: { type: :string },
            password: { type: :string }
          },
          required: [ 'id', 'name']

        let(:id) { Student.create(name: 'foo', email: 'asdfas3242', password: 'dfssasdsf3242').id }
        run_test!
      end
    end
  end
end