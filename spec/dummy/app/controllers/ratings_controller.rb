class RatingsController < ApplicationController
  include Wizardry

  wizard 'rating' do
    class_name 'Rating'
    edit_path_helper :ratings_page_path
    update_path_helper :ratings_path

    page :identification do
      title 'Who are you?'
      questions do
        short_answer :full_name
        email_address :name
      end
    end

    page :address do
      title 'Address'
      questions do
        short_answer :address_1
        short_answer :address_2
        short_answer :town
        short_answer :postcode
      end
    end

    page :contact_details do
      title 'Contact details'
      questions do
        telephone_number :phone
        email_address :email
      end
    end

    page :feedback do
      title 'What did you think about our service?'
      questions do
        short_answer :customer_type
        date :purchase_date
        long_answer :feedback
        radios :rating, {
          1 => 'Dire', 2 => 'Alright', 3 => 'Average', 4 => 'Decent', 5 => 'Amazing'
        }
      end
    end
  end
end
