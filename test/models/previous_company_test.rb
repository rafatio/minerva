# frozen_string_literal: true

require 'test_helper'

class PreviousCompanyTest < ActiveSupport::TestCase
  test 'check number of previous companies' do
    assert_equal 3, PreviousCompany.count
  end

  test 'check previous companies data' do
    pc1 = previous_companies(:previous_company_user1_1)
    assert_equal 'Empresa antiga 1', pc1.name
    assert_equal 'Empresa 1', pc1.professional_information.company
  end
end
