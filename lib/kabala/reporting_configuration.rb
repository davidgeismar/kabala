require 'fileutils'
module Kabala
  class ReportingConfiguration
    attr_accessor :csv_file_path
    # default config should build perf_reports/klass/action/threads_num/inserts_per_threads
    def initialize(*folders)
      @folders = folders.map(&:to_s)
      @csv_file_path = CSVFilePath.new(@folders).build
      build_folders
    end

    def build_folders
      path = Rails.root.join('perf_reports', *@folders).to_s
      FileUtils::mkdir_p(path)
    end
  end
end
