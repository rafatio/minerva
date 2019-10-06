require 'test_helper'

class PreviousCompanyTest < ActiveSupport::TestCase

  test "check number of professional information entries" do
    assert_equal 2, ProfessionalInformation.count
  end

  test "check professional informations data" do
    pi1 = professional_informations(:professional_info_1)
    assert_equal 'Empresa 1', pi1.company
    assert_equal 'person 1', pi1.user.person.name
    assert_equal 2, pi1.previous_companies.count
    assert_equal 'Empresa antiga 2', pi1.previous_companies[0].name
    assert_equal 'Empresa antiga 1', pi1.previous_companies[1].name
  end
end