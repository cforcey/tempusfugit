require 'spec_helper'

describe SpansController do
  describe 'routing' do

    it 'routes to #index' do
      get('/spans').should route_to('spans#index')
    end

    it 'routes to #new' do
      get('/spans/new').should route_to('spans#new')
    end

    it 'routes to #show' do
      get('/spans/1').should route_to('spans#show', :id => '1')
    end

    it 'routes to #edit' do
      get('/spans/1/edit').should route_to('spans#edit', :id => '1')
    end

    it 'routes to #create' do
      post('/spans').should route_to('spans#create')
    end

    it 'routes to #update' do
      put('/spans/1').should route_to('spans#update', :id => '1')
    end

    it 'routes to #destroy' do
      delete('/spans/1').should route_to('spans#destroy', :id => '1')
    end

  end
end
