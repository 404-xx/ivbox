require 'digest/sha1'
require 'mime/types'

module EverBox
  module FS

    class << self

      # Params:
      #   token = "<token>",
      #   path = "<path>",
      #   options = {
      #     :base       => nil,
      #     :attachment => nil,
      #     :show_list  => 1,
      #     :show_type  => 3
      #   }
      def get token, path, options = {}
        raise ArgumentError, "Invalid token." if token.empty?
        raise ArgumentError, "Invalid path." if path.empty?
        params = {
          :token    => token,
          :path     => path,
          :base     => options[:base],
          :list     => options[:show_list],
          :attName  => options[:attachment],
          :showType => options[:show_type]
        }.to_json
        http_request EVERBOX_FS_GET, params
      end

      def mkdir token, path, edit_time = nil
        raise ArgumentError, "Invalid token." if token.empty?
        raise ArgumentError, "Invalid path." if path.empty?
        edit_time = Time.now if edit_time.nil?
        edit_time_utc = edit_time.utc.strftime "%Y-%m-%d %H:%M:%S UTC"
        params = {
          :token    => token,
          :path     => path,
          :editTime => edit_time_utc
        }.to_json
        http_request EVERBOX_FS_MKDIR, params
      end

      def move token, from, to
        move_or_copy EVERBOX_FS_MOVE, token, from, to
      end

      def copy token, from, to
        move_or_copy EVERBOX_FS_COPY, token, from, to
      end

      def delete token, *paths
        remove_or_revert EVERBOX_FS_DELETE, token, paths
      end

      def undelete token, *paths
        remove_or_revert EVERBOX_FS_UNDELETE, token, paths
      end

      def purge token, *paths
        remove_or_revert EVERBOX_FS_PURGE, token, paths
      end

      def info token
        info_or_check EVERBOX_FS_INFO, token
      end

      def check token
        info_or_check EVERBOX_FS_CHECK, token
      end

      def make_file token, source_file, target_path, ver = ''
        f = File.open(source_file, "rb")
        fsize = f.stat.size
        ftime = f.mtime.utc.strftime "%Y-%m-%d %H:%M:%S UTC"

        # detect the MIME type of a file, based on its filename extension
        # mimetype = `file -Ib #{path}`.gsub(/\n/,"")
        fmtype = MIME::Types.type_for(target_path)[0].content_type

        keys = []
        last_index = -1
        chunk_size = EVERBOX_FILE_CHUNK_SIZE

        until f.eof?
          fpart = f.read chunk_size
          keys << urlsafe_base64_encode(Digest::SHA1.digest(fpart))
          ++last_index
        end
        f.rewind

        params = {
          :token     => token,
          :path      => target_path,
          :keys      => keys,
          :chunkSize => chunk_size,
          :fileSize  => fsize,
          :base      => ver
        }
        code, data = http_request EVERBOX_FS_PREPARE_PUT, params.to_json, :method => :post
        if code != EVERBOX_OK
          f.close
          return [code, data]
        end

        unless data['required'].empty?
          data['required'].each do |chunk|
            index = chunk['index']
            bytes = (index != last_index ? chunk_size : fpart.size)
            f.seek index * chunk_size
            code, response = http_request chunk['url'], f.read(bytes), :method => :put
            if code != EVERBOX_OK
              f.close
              return [code, response]
            end
          end
        end

        f.close

        params = params.merge :editTime => ftime, :mimeType => fmtype
        code, response = http_request EVERBOX_FS_COMMIT_PUT, params.to_json, :method => :post
        [code, response]
      end

      def upload token, source_file, target_path
        n = 0
        origin_target_path = target_path

        begin
          finfo = File.pathinfo(origin_target_path)
          if n > 0
            target_path = finfo[:dirname] + '/' + finfo[:filename] + "(#{n})" + finfo[:extension]
          end

          code, response = make_file token, source_file, target_path
          if code == EVERBOX_OK
            response["path"] = target_path
            return [EVERBOX_OK, response]
          end

          n += 1
        end while code == EVERBOX_CONFLICTED
        [code, response]
      end


      private

        def move_or_copy url, token, from, to
          raise ArgumentError, "Invalid token." if token.empty?
          raise ArgumentError, "Invalid source path(form)." if from.empty?
          raise ArgumentError, "Invalid target path(to)." if from.empty?
          params = {:token => token, :from  => from, :to => to}.to_json
          http_request url, params
        end

        def remove_or_revert url, token, paths
          raise ArgumentError, "Invalid token." if token.empty?
          raise ArgumentError, "Invalid paths." if paths.empty?
          params = {:token => token, :paths => paths.flatten}.to_json
          http_request url, params
        end

        def info_or_check url, token
          raise ArgumentError, "Invalid token." if token.empty?
          params = {:token => token}.to_json
          http_request url, params
        end

    end
  end
end
