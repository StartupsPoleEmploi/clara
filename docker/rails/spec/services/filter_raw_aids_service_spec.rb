require 'rails_helper'

describe FilterRawAidsService do

  describe '#filter_raw_aids' do

    input = [
      {  
       'id'=>41,
       'name'=>'aid_name',
       'what'=>'aid_waht',
       'created_at'=>'2017-09-06T13:29:24.815Z',
       'updated_at'=>'2017-09-09T10:10:32.152Z',
       'slug'=>'aid_slug',
       'short_description'=>'aid_short_description',
       'how_much'=>'aid_how_muchb',
       'additionnal_conditions'=>'aid_additional_condition',
       'how_and_when'=>'aid_how_and_when',
       'limitations'=>'aid_limitation',
       'rule_id'=>103,
       'ordre_affichage'=>15,
       'contract_type_id'=>4,
       'archived_at'=>nil,
       'contract_type_order'=>1,
       'contract_type_icon'=>'svg_icon',
       'contract_type_description'=>'a contract type description'
     },
     {  
       'id'=>42,
       'name'=>'aid_name2',
       'what'=>'aid_waht2',
       'created_at'=>'2017-09-06T13:29:24.815Z',
       'updated_at'=>'2017-09-09T10:10:32.152Z',
       'slug'=>'aid_slug2',
       'short_description'=>'aid_short_description2',
       'how_much'=>'aid_how_muchb2',
       'additionnal_conditions'=>'aid_additional_condition2',
       'how_and_when'=>'aid_how_and_when2',
       'limitations'=>'aid_limitation2',
       'rule_id'=>104,
       'ordre_affichage'=>16,
       'contract_type_id'=>4,
       'archived_at'=>nil,
       'contract_type_order'=>1,
       'contract_type_icon'=>'svg_icon',
       'contract_type_description'=>'a contract type description'
     },
     {  
       'id'=>43,
       'name'=>'aid_name3',
       'what'=>'aid_waht3',
       'created_at'=>'2017-09-06T13:29:24.815Z',
       'updated_at'=>'2017-09-09T10:10:32.152Z',
       'slug'=>'aid_slug2',
       'short_description'=>'aid_short_description3',
       'how_much'=>'aid_how_muchb3',
       'additionnal_conditions'=>'aid_additional_condition3',
       'how_and_when'=>'aid_how_and_when3',
       'limitations'=>'aid_limitation3',
       'rule_id'=>105,
       'ordre_affichage'=>17,
       'contract_type_id'=>22,
       'archived_at'=>nil,
       'contract_type_order'=>26,
       'contract_type_icon'=>'svg_icon22',
       'contract_type_description'=>'another contract type description'
     }]

     it 'returns something' do
      output = FilterRawAidsService.new(input).go

      expect(output[0]['aids']).to eq ([
        {
          'id'=> 41,
          'name'=> 'aid_name',
          'ordre_affichage'=> 15,
          'short_description'=> 'aid_short_description',
          'slug'=> 'aid_slug'
        },
        {
          'id'=> 42,
          'name'=> 'aid_name2',
          'ordre_affichage'=> 16,
          'short_description'=> 'aid_short_description2',
          'slug'=> 'aid_slug2'
        }
      ])
      expect(output[1]['aids']).to eq ([
        {
          'id'=> 43,
          'name'=> 'aid_name3',
          'ordre_affichage'=> 17,
          'short_description'=> 'aid_short_description3',
          'slug'=> 'aid_slug2'
        }
      ])

      expect(output[0]['description']).to eq('a contract type description');
      expect(output[0]['icon']).to eq('svg_icon');
      expect(output[0]['order']).to eq(1);
      expect(output[0]['unfold']).to eq({'value' => false});

      expect(output[1]['description']).to eq('another contract type description');
      expect(output[1]['icon']).to eq('svg_icon22');
      expect(output[1]['order']).to eq(26);
      expect(output[1]['unfold']).to eq({'value' => false});
    end
  end

end
