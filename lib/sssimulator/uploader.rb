module Sssimulator

  class Uploader
    def initialize(params)
      @params = params
    end

    def process
      filename = @params[:file][:filename]
      tempfile = @params[:file][:tempfile]
      write_to_file = File.join([settings.root, "storage", @params[:key] + '.' + filename.split('.').last])
      File.open(filename, 'w') {|f| f.write tempfile.read}
      write_to_file
    end
  end

end
