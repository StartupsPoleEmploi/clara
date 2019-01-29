MagicLamp.define do

  fixture(name: "aides") do
    render partial: 'test/aides'
  end

  fixture(name: "c-simulator-result") do
    render partial: 'admin/shared/c-simulator-result'
  end

  fixture(name: "realistic_paginated_aid_collection") do
    render partial: 'test/realistic_aid_collection'
  end

end
