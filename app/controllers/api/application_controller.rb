class Api::ApplicationController < ApplicationController
  def render_json(obj, status = :ok)
    render json: obj, status: status
  end

  def render_not_found(subject)
    render json: { message: "#{subject} is not found." }, status: :not_found
  end

  def render_unprocessable(subject)
    render json: { message: "#{subject} is unprocessable." }, status: :unprocessable_entity
  end

  def render_fatal(subject)
    render json: { message: "#{subject} is fatal." }, status: :internal_server_error
  end

end
