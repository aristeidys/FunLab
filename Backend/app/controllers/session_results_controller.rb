class SessionResultsController < ApplicationController
  
    before_action :set_session_result, only: [:show, :update, :destroy]
    
    def index  
      render json: Student.find(params[:student_id]).session_results.to_json()
    end
    
    # GET ONE
    def show
      render json: @sr.to_json()
    end
    
    # POST
    def create
        @sr = SessionResult.new(session_result_params)
        @sr.session_id = params[:session_id]
        @sr.student_id = params[:student_id]
      if @sr.save
        render json: @sr.to_json(), status: :created
      else
        render json: @sr.errors, status: :unprocessable_entity
      end
    end
    
    # UPDATE
    def update
      if @sr.update(session_params)
        render json: @sr
      else 
        render json: @sr.errors, status: :unprocessable_entity
      end
    end
    
    # DELETE
    def destroy
      @sr.destroy
    end
    
    private
        def set_session_result
          @sr = SessionResult.find(params[:id])
        end
        def session_result_params
          params.require(:session_result).permit(:session_id, :student_id)
        end
  end
  