module Rack
  class Request
    module Helpers
      def scheme
        if get_header(HTTPS) == 'on'
          'https'
        elsif get_header(HTTP_X_FORWARDED_SSL) == 'on'
          'https'
        elsif get_header('HTTP_CF_VISITOR')
          h = get_header('HTTP_CF_VISITOR')
          JSON.parse(h)['scheme']
        elsif get_header(HTTP_X_FORWARDED_SCHEME)
          get_header(HTTP_X_FORWARDED_SCHEME)
        elsif get_header(HTTP_X_FORWARDED_PROTO)
          get_header(HTTP_X_FORWARDED_PROTO).split(',')[0]
        else
          get_header(RACK_URL_SCHEME)
        end
      end
    end
  end
end
