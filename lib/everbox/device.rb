module EverBox
  module Device
    class << self

=begin
      HTTP: POST /device/set
      PARAMS(JSON): {
        token: "<Token>",
        devId: "<DevId>",
        devName: "<DevFriendlyName>"
      }
      RETURN(JSON):
        200 OK
        403 Forbidden {
          error: "BadAuthentication"
        }
=end
      def set token, device_id, device_name
        params = {:token => token, :devId => device_id, :devName => device_name}.to_json
        http_request EVERBOX_DEVICE_SET, params
      end

=begin
    HTTP: POST /device/list
    PARAMS(JSON): {
      token: "<Token>"
    }
    RETURN(JSON):
      200 OK {
        devices: [{devId: <DevId>, devName: <DevName>}, ...]
      }
      403 Forbidden {
        error: "BadAuthentication"
      }
=end
      def list token
        params = {:token => token}.to_json
        http_request EVERBOX_DEVICE_LIST, params
      end

=begin
    HTTP: POST /device/unlink
    PARAMS(JSON): {
      token: "<Token>",
      devId: "<DevId>"
    }
    RETURN(JSON):
      200 OK
      403 Forbidden {
        error: "BadAuthentication"
      }
      
      @arg [in] devId: 与设备相关的唯一标识符。
      @note: 设备 unlink 后，该设备的everbox访问服务器将被拒绝。
=end
      def unlink token, device_id
        params = {:token => token, :devId => device_id}.to_json
        http_request EVERBOX_DEVICE_UNLINK, params
      end

    end
  end
end
