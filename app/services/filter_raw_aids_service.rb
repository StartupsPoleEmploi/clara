class FilterRawAidsService

  def initialize(raw_aids)
    @raw_aids = raw_aids
  end

  def go
    all_lines = []
    if @raw_aids.is_a?(Array) && @raw_aids.size > 0 && @raw_aids.all?{|e| e.is_a?(Hash)}
      grouped = @raw_aids.group_by { |e| e['contract_type_id'] }
      all_lines = grouped.map do |k,v|
        result = {}
        result['aids'] = v.map{|i| {'id' => i['id'], 'name' => i['name'], 'ordre_affichage' => i['ordre_affichage'], 'short_description' => i['short_description'], 'slug' => i['slug']  }}
        result['contract_type_id'] = v[0]['contract_type_id']
        result['contract_type_business_id'] = v[0]['contract_type_business_id']
        result['description'] = v[0]['contract_type_description']
        result['icon'] = v[0]['contract_type_icon']
        result['order'] = v[0]['contract_type_order']
        result['unfold'] = {'value' => false}
        # p '- - - - - - - - - - - - - - result- - - - - - - - - - - - - - - -' 
        # pp result
        # p ''
        result
      end
    end
    all_lines
  end


end

