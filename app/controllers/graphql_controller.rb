class GraphqlController < ApplicationController
  def execute
    variables = prepare_variables(
      params[:variables]
    )
    query = params[:query]
    operation_name = params[:operationName]

    context = {
      current_user: current_user
    }

    result = TaskManagerApiSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )

    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def current_user
    token = request.headers["Authorization"]
      &.split(" ")
      &.last

    return nil unless token

    begin
      payload = Warden::JWTAuth::TokenDecoder
        .new.call(token)
      User.find(payload["sub"])
    rescue JWT::DecodeError,
           ActiveRecord::RecordNotFound
      nil
    end
  end

  def prepare_variables(variables_param)
    case variables_param
    when String
      variables_param.present? ?
        JSON.parse(variables_param) || {} : {}
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError,
        "Unexpected type: #{variables_param.class}"
    end
  end

  def handle_error_in_development(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")
    render json: {
      errors: [ { message: err.message,
                 backtrace: err.backtrace } ],
      data: {}
    }, status: 500
  end
end
