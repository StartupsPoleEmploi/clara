require 'rails_helper'

describe CalculateAskerService do

  it '.calculate_zrr!' do
    res = CalculateAskerService.new(Asker.new).calculate_zrr!
    expect(res).to eq("blabla")

  end

end
