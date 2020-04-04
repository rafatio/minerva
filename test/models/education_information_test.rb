require 'test_helper'

class EducationInformationTest < ActiveSupport::TestCase
  test 'check number of education information entries' do
    assert_equal 4, EducationInformation.count
  end

  test 'check education informations data' do
    ei1 = education_informations(:education_info_user1_1)
    assert_equal 'Graduação', ei1.education_level.name

    assert_equal 3, ei1.user.education_informations.count
  end
end
