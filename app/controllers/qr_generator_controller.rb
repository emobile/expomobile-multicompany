# encoding: utf-8

class QrGeneratorController < ApplicationController
  
  def generate_qr
    if params[:exhibitor]
      @field1a = "Nombre: "
      @field2a = "Trabajo:  "
      @field3a = "Lugar: "
      @field1b = params[:exhibitor_name]
      @field2b = params[:exhibitor_job]
      @field3b = params[:stand_location]
    else
      @field1a = "Taller: "
      @field2a = "Instructor: "
      @field3a = p"Salón: "
      @field1b = params[:workshop_name]
      @field2b = params[:teacher_name]
      @field3b = params[:room]
    end
    @qr_code = "https://chart.googleapis.com/chart?cht=qr&chs=#{256}x#{256}&chl=#{SystemConfiguration.first.token}:#{params[:key]}"
    render layout: false
  end
  
end