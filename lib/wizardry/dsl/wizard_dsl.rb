module Wizardry
  module Dsl
    class WizardDsl
      def self.parse_dsl(name, &block)
        @dsl = Wizardry::Dsl::WizardDsl.new(name)
        @dsl.instance_exec(&block)
        @dsl.to_options
      end

      def initialize(string)
        @name = string
        @pages = []
      end

      def class_name(string)
        @class_name = string
      end

      def edit_path_helper(symbol)
        @edit_path_helper = symbol
      end

      def update_path_helper(symbol)
        @update_path_helper = symbol
      end

      def page(identifier, &block)
        page = PageDsl.new(identifier)
        page.instance_exec(&block)
        @pages << page
      end

      def to_options
        {
          name: @name,
          class_name: @class_name,
          edit_path_helper: @edit_path_helper,
          update_path_helper: @update_path_helper,
          pages: @pages.map(&:to_options).push(Wizardry::Pages::CheckYourAnswersPage.new)
        }
      end
    end
  end
end
