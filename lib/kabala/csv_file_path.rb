module Kabala
  class CSVFilePath
    def initialize(folders)
      @folders = folders
    end

    def build
      filename = Time.now.to_i
      Rails.root.join('lib', 'tasks', "perf_reports", *@folders, "#{filename}.csv")
    end
  end
end
