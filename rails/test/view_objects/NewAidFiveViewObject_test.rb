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
 
 end
