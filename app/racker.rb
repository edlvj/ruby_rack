require 'erb'
require 'json'
require 'edlvj_codebreaker'

class Racker
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @game = @request.session[:game]
  end

  def response
    case @request.path
      when '/' then render 'index'
      when '/start' then start_game 
      when '/match' then  guess 
      when '/hint' then hint
      when '/save_score' then save_score 
      when '/score' then score  
      else Rack::Response.new('Not Found', 404)
    end
  end
  
  def guess
    render_json ([ result: guess_match(@request.params['code']), attempts: @game.attempts ])
  end
  
  def start_game
    @request.session[:game] = Codebreaker::Game.new
    render_json true
  end  
  
  def hint
    render_json @game.get_hint
  end  
  
  def score
    render_json @game.stat 
  end  
  
  def save_score 
    @game.save_stat @request.params['username']
    render_json true
  end  
  
  def guess_match( code )
    if @game.win? 
      true
    elsif @game.loose?
      false 
    else  
     @game.match_guess code
    end
  end  
  
  def render_json(data)
    Rack::Response.new(data.to_json, 200, {'Content-Type' => 'application/json'})
  end

  def render(template)
    path = File.expand_path("../views/#{template}.html.erb", __FILE__)
    result = ERB.new(File.read(path)).result(binding)
    Rack::Response.new(result)
  end

end