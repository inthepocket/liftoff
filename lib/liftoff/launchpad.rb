module Liftoff
  class LaunchPad
    EX_NOINPUT = 66

    def liftoff(options)
      puts "Initiating launch sequence...\n".colorize(:green)

      liftoffrc = ConfigurationParser.new(options).project_configuration
      @config = ProjectConfiguration.new(liftoffrc)
      if project_exists?
        perform_project_actions
      else
        validate_template
        fetch_options

        file_manager.create_project_dir(@config.path) do
          generate_project
          setup_dependency_managers
          generate_templates
          install_crashlytics
          generate_settings
          install_dependencies
          perform_project_actions
          open_project
        end
      end
    end

    private

    def validate_template
      unless @config.app_target_groups
        STDERR.puts "Invalid template name: '#{@config.project_template}'"
        exit EX_NOINPUT
      end
    end

    def fetch_options
      OptionFetcher.new(@config).fetch_options
    end

    def perform_project_actions
      puts "Performing project actions...".colorize(:blue)
      set_indentation_level
      enable_warnings
      enable_other_warnings
      treat_warnings_as_errors
      add_script_phases
      enable_static_analyzer
      perform_extra_config
      save_project
      generate_git
    end

    def setup_dependency_managers
      dependency_manager_coordinator.setup_dependencies
    end

    def install_dependencies
      dependency_manager_coordinator.install_dependencies
    end

    def generate_templates
      puts "Generating templates...".colorize(:blue)
      TemplateGenerator.new(@config).generate_templates(file_manager)
    end

    def install_crashlytics
      puts "Installing Crashlytics...".colorize(:blue)
        CrashlyticsSetup.new(@config).install_crashlytics
    end

    def generate_project
      puts "Generating project...".colorize(:blue)
      ProjectBuilder.new(@config).create_project
    end

    def generate_settings
      puts "Generating Settings.bundle...".colorize(:blue)
      SettingsGenerator.new(@config).generate
    end

    def generate_git
      puts "Generating Git...".colorize(:blue)
      GitSetup.new(@config).setup
    end

    def set_indentation_level
      xcode_helper.set_indentation_level(@config.indentation_level, @config.use_tabs)
    end

    def treat_warnings_as_errors
      xcode_helper.treat_warnings_as_errors(@config.warnings_as_errors)
    end

    def add_script_phases
      phases = @config.run_script_phases + dependency_manager_coordinator.run_script_phases_for_dependencies
      xcode_helper.add_script_phases(phases)
    end

    def enable_warnings
      xcode_helper.enable_warnings(@config.warnings)
    end

    def enable_other_warnings
      xcode_helper.enable_other_warnings(@config.other_warnings)
    end

    def perform_extra_config
      xcode_helper.perform_extra_config(@config.extra_config, @config.extra_test_config)
    end

    def enable_static_analyzer
      xcode_helper.enable_static_analyzer(@config.enable_static_analyzer)
    end

    def open_project
      if @config.xcode_command
        puts "\nHouston we have a liftoff! 🚀".colorize(:green)
        `#{@config.xcode_command}`
      end
    end

    def save_project
      xcode_helper.save
    end

    def project_exists?
      Dir.glob('*.xcodeproj').count > 0
    end

    def xcode_helper
      @xcode_helper ||= XcodeprojHelper.new(@config)
    end

    def file_manager
      @file_manager ||= FileManager.new
    end

    def dependency_manager_coordinator
      @dependency_manager_coordinator ||=
        DependencyManagerCoordinator.new(dependency_managers)
    end

    def dependency_managers
      @dependency_managers ||= [cocoapods, carthage]
    end

    def cocoapods
      if @config.dependency_manager_enabled?("cocoapods")
        Cocoapods.new(@config)
      else
        NullDependencyManager.new(@config)
      end
    end

    def carthage
      if @config.dependency_manager_enabled?("carthage")
        Carthage.new(@config)
      else
        NullDependencyManager.new(@config)
      end
    end
  end
end
