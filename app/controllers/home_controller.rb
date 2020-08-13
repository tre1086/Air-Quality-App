class HomeController < ApplicationController
  def index
    
    require 'net/http'
    require 'json'
    
    @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=64151&distance=0&API_KEY=A1931E82-710B-4C30-849A-2F1034D7EE51'    
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
  
    # Check for empty return result
    if @output.empty?
        @final_output = "Error"
    elsif !@output
      @final_output = "Error"
    else 
      @final_output = @output[0]['AQI']  
    end
    
    if @final_output == "Error"
      api_color = "gray"
    elsif @final_output <= 50
      @api_color = "green"
      @api_description = "0 - 50 Good"
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "yellow"
      @api_description = "51 - 100 Mooderate"
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "orange"
      @api_description = "101 - 150 Unhealthy for Sensitive Groups (USG)"
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "red"
      @api_description = "151 - 200 Unhealthy"
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "purple"
      @api_description = "201 - 300 Very Unhealthy"
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "maroon"
      @api_description = "301 - 500 Hazardous"
    
    end
  end

  def zipcode 
    @zip_query = params[:zipcode]
    
    if params[:zipcode] == ""
      @zip_query = "Hey you forgot to enter a zipcode!"
    elsif params[:zipcode]
      # Do Api stuff
  
      require 'net/http'
      require 'json'
      @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + "#{@zip_query}" + '&distance=0&API_KEY=A1931E82-710B-4C30-849A-2F1034D7EE51'    
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
    
      # Check for empty return result
      if @output.empty?
          @final_output = "Error"
      elsif !@output
        @final_output = "Error"
      else 
        @final_output = @output[0]['AQI']  
      end
      
      if @final_output == "Error"
        api_color = "gray"
      elsif @final_output <= 50
        @api_color = "green"
        @api_description = "0 - 50 Good"
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = "yellow"
        @api_description = "51 - 100 Mooderate"
      elsif @final_output >= 101 && @final_output <= 150
        @api_color = "orange"
        @api_description = "101 - 150 Unhealthy for Sensitive Groups (USG)"
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = "red"
        @api_description = "151 - 200 Unhealthy"
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = "purple"
        @api_description = "201 - 300 Very Unhealthy"
      elsif @final_output >= 301 && @final_output <= 500
        @api_color = "maroon"
        @api_description = "301 - 500 Hazardous"
      end
    end
  end
end
