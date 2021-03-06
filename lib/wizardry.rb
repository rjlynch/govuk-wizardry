require "wizardry/engine"
require "wizardry/railtie"
require "wizardry/framework"
require "wizardry/instance"

require "wizardry/pages/page"
require "wizardry/pages/check_your_answers_page"

require "wizardry/questions/answer"
require "wizardry/questions/short_answer"
require "wizardry/questions/long_answer"
require "wizardry/questions/radios"
require "wizardry/questions/telephone_number"
require "wizardry/questions/email_address"
require "wizardry/questions/date"

require "govuk_design_system_formbuilder"

module Wizardry
  extend ActiveSupport::Concern

  class_methods do
    def wizard(...)
      define_method(:wizard) do
        @framework ||= Wizardry::Framework.new(...)
      end
    end
  end

  included do
    before_action :setup_wizard

    def edit
    end

    def update
      next_page_name = @wizard.next_page.name

      Rails.logger.debug("🧙 Object valid, saving and moving on")
      @wizard.object.assign_attributes(object_params.merge(last_completed_step_params))

      if @wizard.object.save(context: @wizard.current_page.name)
        Rails.logger.debug("🧙 Object valid, saving and moving on")

        redirect_to send(@wizard.framework.edit_path_helper, next_page_name)
      else
        Rails.logger.debug("🧙 Object not valid, try again")

        render :edit
      end
    end

  private

    def setup_wizard
      Rails.logger.debug("🧙 Finding or initialising #{wizard.class_name} with '#{identifier}'")

      object = wizard.class_name.constantize.find_or_initialize_by(identifier: identifier)

      Rails.logger.debug("🧙 Initialising the wizard 🪄")

      @wizard = Wizardry::Instance.new(current_page: params[:page], object: object, framework: @framework)
    end

    def object_params
      params.require(@wizard.framework.class_name.constantize.model_name.param_key).permit(@wizard.current_page.question_names)
    end

    def last_completed_step_params
      { last_completed_step: @wizard.current_page.name }
    end

    def identifier
      cookies.fetch(wizard.cookie_name) { cookies[wizard.cookie_name] = SecureRandom.uuid }
    end
  end
end
