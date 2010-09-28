require 'net/http'
require 'uri'

class Site

  def initialize(url)
    @url = URI.parse(url)
  end
  
  def url
    @url
  end
  
  def check
    begin
      response = Net::HTTP.get_response(@url)
      case response
      when Net::HTTPSuccess, Net::HTTPRedirection
        @status = "200 OK"
      else
        @status = res.error!
      end
    rescue Exception => e
      @status = e.message
    end
  end
  
  def to_s
    @url.to_s
  end
  
  def status
    @status
  end
  
  def class
    return "ok" if @status == "200 OK"
    return "error"
  end

end
