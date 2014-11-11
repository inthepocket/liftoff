module Liftoff
  class CocoapodsSetup
    def initialize(config)
      @config = config
    end

    def generate_podfile()
      if @config.use_cocoapods
        if pod_installed?
          move_podfile
        else
          puts 'Please install CocoaPods or disable pods from liftoff'
        end
      end
    end

    def install_pods
      if pod_installed?
        puts 'Running pod install'
        system('pod install')
      end
    end

    private

    def pod_installed?
      system('which pod > /dev/null')
    end

    def move_podfile
      FileManager.new.generate('Podfile', 'Podfile', @config)
    end
  end
end
