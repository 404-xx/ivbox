require 'base64'

def urlsafe_base64_encode content
  Base64.encode64(content).strip.gsub('+', '-').gsub('/','_')
end

def urlsafe_base64_decode encoded_content
  Base64.decode64 encoded_content.gsub('_','/').gsub('-', '+')
end

#   options = {
#     :method       => :get | :post | :put,
#     :content_type => :json | 'text/plain' | ...,
#     :accept       => :json | ...,
#     ...
#   }
def http_request url, data, options = {}
  begin
    options[:method] = :post unless options[:method]
    case options[:method]
    when :get
      response = RestClient.get url, data, :content_type => options[:content_type]
    when :post
      response = RestClient.post url, data, :content_type => options[:content_type]
    when :put
      response = RestClient.put url, data
    end
    body = response.body
    data = nil
    data = JSON.parse body unless body.empty?
    [response.code, data]
  rescue => e
    code = e.response.code
    body = e.response.body
    data = nil
    data = JSON.parse body unless body.empty?
    # data = data.first.last unless data.empty?
    [code, data]
  end
end

class File
  def self.pathinfo(path)
    { :basename  => basename(path),
      :dirname   => dirname(path),
      :extension => extname(path),
      :filename  => basename(path, extname(path))
    }
  end
end
