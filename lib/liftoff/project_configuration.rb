module Liftoff
  class ProjectConfiguration
    LATEST_IOS = 8.0

    attr_accessor :project_name,
      :project_path,
      :company,
      :prefix,
      :test_target_name,
      :configure_git,
      :enable_settings,
      :warnings_as_errors,
      :enable_static_analyzer,
      :indentation_level,
      :warnings,
      :other_warnings,
      :templates,
      :project_template,
      :app_target_templates,
      :test_target_templates,
      :use_cocoapods,
      :use_crashlytics,
      :run_script_phases,
      :strict_prompts,
      :xcode_command,
      :extra_config,
      :abs_project_identifier,
      :enable_parse,
      :enable_googleanalytics

    attr_writer :author,
      :company_identifier,
      :use_tabs

    def initialize(liftoffrc)
      deprecations = DeprecationManager.new
      liftoffrc.each_pair do |attribute, value|
        if respond_to?("#{attribute}=")
          send("#{attribute}=", value)
        else
          deprecations.handle_key(attribute)
        end
      end

      deprecations.finish
    end

    def project_name=(project_name)
      @project_name = project_name
      @project_path = File.join(Dir.pwd, project_name, "#{project_name}.xcodeproj")
    end

    def author
      @author || Etc.getpwuid.gecos.split(',').first
    end

    def company_identifier
      @company_identifier || "com.#{normalized_company_name}"
    end

    def use_tabs
      if @use_tabs
        '1'
      else
        '0'
      end
    end

    def deployment_target
      LATEST_IOS
    end

    def each_template(&block)
      return enum_for(__method__) unless block_given?

      templates.each do |template|
        template.each_pair(&block)
      end
    end

    def info_plist
      "#{@project_name}/Resources/Other-Sources/Info.plist"
    end

    def get_binding
      binding
    end

    def app_target_groups
      @app_target_templates[@project_template]
    end

    def test_target_groups
      @test_target_templates[@project_template]
    end

    private

    def normalized_company_name
      company.force_encoding('utf-8').gsub(/[^0-9a-z]/i, '').downcase
    end

    def normalized_project_name
      project_name.gsub(/[^0-9a-z]/i, '').downcase
    end
  end
end
