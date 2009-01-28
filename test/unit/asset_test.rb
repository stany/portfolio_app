require 'test_helper'

class AssetTest < ActiveSupport::TestCase

  test "Factory should be valid" do
     asset = Factory(:asset)
     assert asset.valid?
     asset.destroy
  end
end
