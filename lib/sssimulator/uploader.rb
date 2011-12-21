module Sssimulator

  class Uploader
    def initialize(params, settings)
      @params = params
      @sinatra_settings = settings
    end

    def process
      filename = @params[:key].gsub('/', '_')
      tempfile = @params[:file][:tempfile]
      write_to_file = File.join(@sinatra_settings.root, "storage", filename)
      File.open(write_to_file, 'w') {|f| f.write tempfile.read}
      write_to_file
    end
  end

end
