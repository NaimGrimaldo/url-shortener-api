# frozen_string_literal: true

module BasicCrudMethods
  def index
    @collection = scope
    render json: @collection, status: :ok
  end

  def create
    @object = model.new(object_params)
    if @object.save
      render json: @object, status: :created, location: @object
    else
      render_error(@object.errors.full_messages.to_sentence,
                   :unprocessable_entity)
    end
  end

  def update
    if set_object.update(object_params)
      render json: @object
    else
      render_error(@object.errors.full_messages.to_sentence,
                   :unprocessable_entity)
    end
  end

  def show
    set_object
    render json: @object, status: :ok
  rescue StandardError, ActiveRecord::RecordNotFound => e
    render_error(e.message, :unprocessable_entity)
  end

  def destroy
    if set_object.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def set_object
    @object = model.find(params[:id])
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end
