module Wizardry
  module Dsl
    class PageDsl
      def initialize(identifier)
        @identifier = identifier
      end

      def title(string)
        @title = string
      end

      def questions(&block)
        question = QuestionDsl.new
        question.instance_exec(&block)
        @questions = question
      end

      def to_options
        Wizardry::Pages::Page.new(
          @identifier,
          title: @title,
          questions: @questions.to_options
        )
      end
    end
  end
end
