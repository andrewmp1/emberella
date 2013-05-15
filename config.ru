require 'bundler/setup'
require 'ember-dev'

class NoCache
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env).tap do |status, headers, body|
      headers["Cache-Control"] = "no-store"
    end
  end
end

use NoCache

# This is not ideal
map "/lib" do
  run Rack::Directory.new('lib')
end

run EmberDev::Server.new
