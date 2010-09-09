dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

%w(rubygems rest_client json mime/types).each do |dependency|
  begin
    require dependency
  rescue LoadError => e
    raise e
  end
end

%w(config version utils fs device).each do |lib|
  require "everbox/#{lib}"
end
