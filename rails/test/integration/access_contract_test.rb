require 'test_helper'

class AccessContractTest < ActionDispatch::IntegrationTest
  
  ########################################################
  ############               LIST           ##############
  ########################################################
  test "Un superadmin peut lister les rubriques" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    #when
    get admin_contract_types_path
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lister les rubriques" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_contract_types_path
    end
  end

  test "Un contributeur ne peut pas lister les rubriques" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    #then
    assert_raises SecurityError do
      #when
      get admin_contract_types_path
    end
  end
  

  ########################################################
  ############               READ           ##############
  ########################################################
  test "Un superadmin peut lire une rubrique" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #when
    get admin_contract_type_path(contract.id)
    #then
    assert_response :ok
  end
  
  test "Un relecteur ne peut pas lire une rubrique" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      get admin_contract_type_path(contract.id)
    end
  end

  test "Un contributeur ne peut pas lire une rubrique" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      get admin_contract_type_path(contract.id)
    end
  end
  
  
  ########################################################
  ############               EDIT             ############
  ########################################################
  test "Un superadmin peut accéder à l'édition d'une rubrique" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #when
    get edit_admin_contract_type_path(contract.id)
    #then
    assert_response :ok
  end

  test "Un relecteur ne peut pas accéder à l'édition d'une rubrique" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_contract_type_path(contract.id)
    end
  end

  test "Un contributeur ne peut pas accéder à l'édition d'une rubrique" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      get edit_admin_contract_type_path(contract.id)
    end
  end
  
  
  ########################################################
  ############               UPDATE             ##########
  ########################################################
  test "Un superadmin peut éditer une rubrique" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #when
    put admin_contract_type_path(contract.id, params: { contract_type: { ordre_affichage: 43 }})
    #then
    assert_response :found
    assert_equal 43, ContractType.last.ordre_affichage
  end
  
  test "Un relecteur ne peut pas éditer une rubrique" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      put admin_contract_type_path(contract.id, params: { contract_type: { ordre_affichage: 43 }})
    end
  end

  test "Un contributeur ne peut pas éditer une rubrique" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      put admin_contract_type_path(contract.id, params: { contract_type: { ordre_affichage: 43 }})
    end
  end

  ########################################################
  ############               DELETE             ##########
  ########################################################
  test "Un superadmin peut supprimer une rubrique" do
    #given
    superadmin = User.create!(role: "superadmin", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: superadmin.email, password: superadmin.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    assert_equal 1, ContractType.count
    #when
    delete admin_contract_type_path(contract.id)
    #then
    assert_response :found
    assert_equal 0, ContractType.count
  end

  test "Un relecteur ne peut pas supprimer une rubrique" do
    #given
    relecteur = User.create!(role: "relecteur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: relecteur.email, password: relecteur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      delete admin_contract_type_path(contract.id)
    end
  end

  test "Un contributeur ne peut pas supprimer une rubrique" do
    #given
    contributeur = User.create!(role: "contributeur", email:"a@b.c", password: "p")
    post session_url, params: { session: { email: contributeur.email, password: contributeur.password }}
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    #then
    assert_raises SecurityError do
      #when
      delete admin_contract_type_path(contract.id)
    end
  end

end
