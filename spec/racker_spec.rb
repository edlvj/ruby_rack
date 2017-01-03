require 'spec_helper'

describe Racker do
   let(:app) { Rack::Builder.parse_file('config.ru').first }
   let(:game) { Codebreaker::Game.new }
 
   context 'Before start' do
    let(:response) { get '/' }
    
    it '/ return http status 200' do
      expect(response.status).to eq 200
    end
    
    let(:response) { get '/start' }
    
    it '/start return http status 200' do
      expect(response.status).to eq 200
    end
    
   end

   context 'After /start' do
     let(:response) do
       get '/hint',{ }, { 'rack.session' => { game: game } }
     end 
     
     it '/hint return http status 200' do
      expect(response.status).to eq 200
     end
     
     let(:response) do
       get '/match',{ code: '1234' }, { 'rack.session' => { game: game } }
     end 
     
     it '/match return http status 200' do
      expect(response.status).to eq 200
     end
     
     let(:response) do
       get '/save_score',{ username: 'test 1' }, { 'rack.session' => { game: game } }
     end 
     
     it '/match return http status 200' do
      expect(response.status).to eq 200
     end
     
     let(:response) do
       get '/score',{ }, { 'rack.session' => { game: game } }
     end 
     
     it '/match return http status 200' do
      expect(response.status).to eq 200
     end
     
   end
end   