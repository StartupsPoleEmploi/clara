require "test_helper"

class NewAidFiveViewObjectTest < ActiveSupport::TestCase
  

  test ".reread_h default value" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    #when
    res = sut.reread_h
    #then
    assert_equal({:class=>"c-newbutton c-newaid-actionrecord js-askforreread", :disabled=>"disabled"}, res)
  end
 
  test ".reread_h could be disabled is not all stages are ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    #when
    res = sut.reread_h
    #then
    assert_equal({:class=>"c-newbutton c-newaid-actionrecord js-askforreread", :disabled=>"disabled"}, res)
  end
 
  test ".reread_h could remove the disabled property if all stages are ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:_all_stages_ok?).and_return(true)
    #when
    res = sut.reread_h
    #then
    assert_equal({:class=>"c-newbutton c-newaid-actionrecord js-askforreread"}, res)
  end

  test ".big_message says 'L'aide a été enregistrée en tant que brouillon.' by default" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    #when
    res = sut.big_message(nil, nil) 
    #then
    assert_equal("L'aide a été enregistrée en tant que brouillon.", res)
  end
 
  test ".big_message says 'Cette aide est actuellement en ligne.' if the status is 'published'" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:status_published?).and_return(true)
    #when
    res = sut.big_message(nil, nil)
    #then
    assert_equal('Cette aide est actuellement en ligne.', res)
  end
 
  test ".big_message says 'L'aide a été archivée.' if the status is 'archived'" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:status_archived?).and_return(true)
    #when
    res = sut.big_message(nil, nil)
    #then
    assert_equal("L'aide a été archivée.", res)
  end
 
  test ".big_message says 'L'aide a toutes les informations requises.' if all stages are ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:_all_stages_ok?).and_return(true)
    #when
    res = sut.big_message(nil, nil) 
    #then
    assert_equal("L'aide a toutes les informations requises.", res)
  end
 
  test ".big_message says 'L'aide est prête à être publiée.' if publishable method returns true" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:publishable?).with('current_user_email', 'current_user_role').and_return(true)
    #when
    res = sut.big_message('current_user_email', 'current_user_role') 
    #then
    assert_equal("L'aide est prête à être publiée.", res)
  end
 
  test ".small_message by default" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    #when
    res = sut.small_message(nil, nil) 
    #then
    assert_equal("Vous pourrez demander une relecture pour publication une fois que toutes les informations obligatoires auront été renseignées.", res)
  end

  test ".small_message if status is published" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:status_published?).and_return(true)
    #when
    res = sut.small_message(nil, nil)
    #then
    assert_equal("Vous pouvez éventuellement l'archiver pour la retirer du site web.", res)
  end
 
  test ".small_message : status archived, and all stages ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:status_archived?).and_return(true)
    allow(sut).to receive(:_all_stages_ok?).and_return(true)
    #when
    res = sut.small_message(nil, nil)
    #then
    assert_equal("Vous pouvez la publier, attention il n'y aura pas de relecture requise.", res)
  end
 
  test ".small_message : status archived, and all stages NOT ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:status_archived?).and_return(true)
    allow(sut).to receive(:_all_stages_ok?).and_return(false)
    #when
    res = sut.small_message(nil, nil)
    #then
    assert_equal("Vous pourrez la publier à nouveau, une fois que les champs obligatoires auront été remplis.", res)
  end
 
  test ".small_message : publishable" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:publishable?).with('current_user_email', 'current_user_role').and_return(true)
    #when
    res = sut.small_message('current_user_email', 'current_user_role') 
    #then
    assert_equal("Veuillez relire attentivement le contenu avant publication.", res)
  end
 
  test ".small_message : _all_stages_ok" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    allow(sut).to receive(:_all_stages_ok?).and_return(true)
    #when
    res = sut.small_message(nil, nil) 
    #then
    assert_equal("Elle sera publiée sur le site après relecture par un tiers.", res)
  end

  test ".small_message : brouillon" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new.attributes.deep_symbolize_keys), aid_status: 'Brouillon'})
    #when
    res = sut.small_message(nil, nil) 
    #then
    assert_equal("Cette aide a déjà été publiée. Elle le sera à nouveau quand les champs obligatoires ci-dessous auront été renseignés.", res)
  end
 
  test ".stage_2_comment : missing keys" do
    #given
    sut = NewAidFive.new(nil, {page: OpenStruct.new(resource: Aid.new)})
    #when
    res = sut.stage_2_comment
    #then
    assert_equal("Des parties <strong>obligatoires</strong> sont manquantes : <strong>Comment faire la demande</strong>, <strong>Contenu de l'aide</strong>, <strong>Description</strong>.", res)
  end
 
  test ".stage_3_comment : default message" do
    #given
    sut = NewAidFive.new(nil, {filters_size: 0, page: OpenStruct.new(resource: Aid.new.attributes.deep_symbolize_keys)})
    #when
    res = sut.stage_3_comment
    #then
    assert_equal("Ni le <strong>résumé</strong>, ni les <strong>filtres</strong> n'ont été renseignés, mais ils ne sont pas obligatoires.", res)
  end
 
  test ".stage_3_comment : no filter" do
    #given
    sut = NewAidFive.new(nil, {filters_size: 0, page: OpenStruct.new(resource: Aid.new(short_description: 'a').attributes.deep_symbolize_keys)})
    #when
    res = sut.stage_3_comment
    #then
    assert_equal("Ni le <strong>résumé</strong>, ni les <strong>filtres</strong> n'ont été renseignés, mais ils ne sont pas obligatoires.", res)
  end
 
  test ".stage_3_comment : no descr" do
    #given
    sut = NewAidFive.new(nil, {filters_size: 1, page: OpenStruct.new(resource: Aid.new(short_description: nil).attributes.deep_symbolize_keys)})
    #when
    res = sut.stage_3_comment
    #then
    assert_equal("Le/les <strong>filtres</strong> ont été renseignés, mais pas le résumé. Ces champs ne sont pas obligatoires.", res)
  end
 
  test ".stage_3_comment : all ok" do
    #given
    sut = NewAidFive.new(nil, {filters_size: 1, page: OpenStruct.new(resource: Aid.new(short_description: 'a').attributes.deep_symbolize_keys)})
    #when
    res = sut.stage_3_comment
    #then
    assert_equal("Le <strong>résumé</strong> et le/les <strong>filtre(s)</strong> ont été renseignés.", res)
  end
 
  test ".stage_4_comment : ok" do
    #given
    sut = NewAidFive.new(nil, {filters_size: 1, page: OpenStruct.new(resource: Aid.new(short_description: 'a').attributes.deep_symbolize_keys)})
    allow(sut).to receive(:stage_4_ok?).and_return(true)
    #when
    res = sut.stage_4_comment
    #then
    assert_equal("Le <strong>champ d'application</strong> a été <strong>correctement renseigné.</strong>", res)
  end
 
  test ".stage_4_comment : NOT ok" do
    #given
    sut = NewAidFive.new(nil, {filters_size: 1, page: OpenStruct.new(resource: Aid.new(short_description: 'a').attributes.deep_symbolize_keys)})
    allow(sut).to receive(:stage_4_ok?).and_return(false)
    #when
    res = sut.stage_4_comment
    #then
    assert_equal("Le <strong>champ d'application</strong> n'a pas été renseigné, il est <strong>obligatoire.</strong>", res)
  end
 

 end
