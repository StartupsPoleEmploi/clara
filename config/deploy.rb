set :stages, %w(staging preproduction production)

require 'mina/multistage'
require 'mina/git'
require 'mina/rails'
require 'mina/rvm'
require 'mina/chruby'
require 'mina/puma'

