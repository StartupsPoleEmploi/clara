require 'rails_helper'

describe DisplayAskerService do

  describe '.go' do
    it 'Returns asker attritubes' do
      #given
      asker = Asker.new
      asker = { 'v_handicap' => 'non', 'v_spectacle' => 'oui', "v_cadre" => 'non'}
      #when
      asker = DisplayAskerService.new(asker).go
      #then
      expect(asker.attritubes).to eq({:v_handicap => "non", :v_spectacle => "oui", :v_cadre => 'non'})
    end
  end

end
 
