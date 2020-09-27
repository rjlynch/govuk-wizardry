module Wizardry
  module Dsl
    class QuestionDsl
      def initialize
        @answers = []
      end

      def short_answer(symbol)
        @answers << Wizardry::Questions::ShortAnswer.new(symbol)
      end

      def email_address(symbol)
        @answers << Wizardry::Questions::EmailAddress.new(symbol)
      end

      def telephone_number(symbol)
        @answers << Wizardry::Questions::TelephoneNumber.new(symbol)
      end

      def date(symbol)
        @answers << Wizardry::Questions::Date.new(symbol)
      end

      def long_answer(symbol)
        @answers << Wizardry::Questions::LongAnswer.new(symbol)
      end

      def radios(symbol, hash)
        @answers << Wizardry::Questions::Radios.new(symbol, hash)
      end

      def to_options
        @answers
      end
    end
  end
end

