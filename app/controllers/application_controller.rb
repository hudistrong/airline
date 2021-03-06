require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  include Clearance::Controller
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions
end
