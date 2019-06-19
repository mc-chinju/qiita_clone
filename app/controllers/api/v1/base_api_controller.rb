class Api::V1::BaseApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
end
