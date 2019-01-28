MagicLamp.define do

  fixture(name: "aides") do
    render partial: 'test/aides'
  end

  fixture(name: "c-simulator-result") do
    render partial: 'admin/shared/c-simulator-result'
  end

  fixture(name: "realistic_paginated_aid_collection") do
    '<table aria-labelledby="page-title"> <thead> <tr> <th class="cell-label cell-label--string cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=name&amp;page=2"> Nom </a> </th> <th class="cell-label cell-label--number cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=id&amp;page=2"> Id </a> </th> <th class="cell-label cell-label--number cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=ordre_affichage&amp;page=2"> Ordre Affichage </a> </th> <th class="cell-label cell-label--string cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=last_update&amp;page=2"> Last Update </a> </th> <th class="cell-label cell-label--belongs-to cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=contract_type&amp;page=2"> Contract Type </a> </th> <th class="cell-label cell-label--has-many cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=need_filters&amp;page=2"> Need Filters </a> </th> <th class="cell-label cell-label--has-many cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=custom_filters&amp;page=2"> Custom Filters </a> </th> <th class="cell-label cell-label--has-many cell-label--false" scope="col" role="columnheader" aria-sort="none"> <a href="/admin/aids?direction=asc&amp;order=filters&amp;page=2"> Filters </a> </th> <th scope="col"></th> <th scope="col"></th> </tr> </thead> <tbody> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/erasmus"> <td class="cell-data cell-data--string"> <a href="/admin/aids/erasmus" class="action-show"> Erasmus + </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/erasmus" class="action-show"> 29 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/erasmus" class="action-show"> 60 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/erasmus" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/erasmus" class="action-show"> </a><a href="/admin/contract_types/emploi-international">Emploi international</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/erasmus" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/erasmus" class="action-show"> 1 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/erasmus" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/erasmus/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/erasmus">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale"> <td class="cell-data cell-data--string"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> Contrat d\'insertion dans la vie sociale (CIVIS) </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> 32 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> 42 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> </a><a href="/admin/contract_types/appui-a-l-embauche">Appui à l\'embauche</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> 1 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale" class="action-show"> 0 filter </a> </td> <td><a class="action-edit" href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/civis-contrat-d-insertion-dans-la-vie-sociale">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/garantie-jeunes"> <td class="cell-data cell-data--string"> <a href="/admin/aids/garantie-jeunes" class="action-show"> Garantie Jeunes </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/garantie-jeunes" class="action-show"> 31 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/garantie-jeunes" class="action-show"> 14 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/garantie-jeunes" class="action-show"> Mai 2018 </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/garantie-jeunes" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-definition-du-projet-professionnel">Aide à la définition du projet professionnel</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/garantie-jeunes" class="action-show"> 1 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/garantie-jeunes" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/garantie-jeunes" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/garantie-jeunes/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/garantie-jeunes">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/volontariat-associatif"> <td class="cell-data cell-data--string"> <a href="/admin/aids/volontariat-associatif" class="action-show"> Volontariat associatif </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/volontariat-associatif" class="action-show"> 38 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/volontariat-associatif" class="action-show"> 53 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/volontariat-associatif" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/volontariat-associatif" class="action-show"> </a><a href="/admin/contract_types/contrat-specifique">Contrat spécifique</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/volontariat-associatif" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/volontariat-associatif" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/volontariat-associatif" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/volontariat-associatif/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/volontariat-associatif">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/programme-yfej"> <td class="cell-data cell-data--string"> <a href="/admin/aids/programme-yfej" class="action-show"> Your First Eures Job (YFEJ) </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/programme-yfej" class="action-show"> 27 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/programme-yfej" class="action-show"> 61 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/programme-yfej" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/programme-yfej" class="action-show"> </a><a href="/admin/contract_types/emploi-international">Emploi international</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/programme-yfej" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/programme-yfej" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/programme-yfej" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/programme-yfej/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/programme-yfej">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/ateliers-pole-emploi"> <td class="cell-data cell-data--string"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> Ateliers Pôle emploi </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> 66 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> 0 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> Mars 2018 </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> </a><a href="/admin/contract_types/appui-a-l-embauche">Appui à l\'embauche</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> 1 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/ateliers-pole-emploi" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/ateliers-pole-emploi/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/ateliers-pole-emploi">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/autres-frais-derogatoires"> <td class="cell-data cell-data--string"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> Autres frais dérogatoires </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> 7 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> 6 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> Mars 2018 </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-mobilite">Aide à la mobilité</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/autres-frais-derogatoires" class="action-show"> 2 filter </a> </td> <td><a class="action-edit" href="/admin/aids/autres-frais-derogatoires/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/autres-frais-derogatoires">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/engagement-de-service-civique"> <td class="cell-data cell-data--string"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> Engagement de service civique </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> 35 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> 50 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> </a><a href="/admin/contract_types/contrat-specifique">Contrat spécifique</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/engagement-de-service-civique" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/engagement-de-service-civique/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/engagement-de-service-civique">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle"> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> Aide aux dépenses de santé des artistes et technic </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> 82 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> 15 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-mobilite">Aide à la mobilité</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/aide-agefiph-au-contrat-d-apprentissage"> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> Aide Agefiph pour l\'alternance </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> 39 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> 22 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> </a><a href="/admin/contract_types/contrat-en-alternance">Contrat en alternance</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/aide-agefiph-au-contrat-d-apprentissage">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle"> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> Aide à la réparation de matériel spécifique aux mé </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> 81 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> 13 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-mobilite">Aide à la mobilité</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/aide-a-la-reparation-de-materiel-specifique-aux-metiers-du-spectacle">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord"> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> Aide départementale Activ\'emploi pour les bénéfici </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> 90 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> 19 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-mobilite">Aide à la mobilité</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord" class="action-show"> 2 filter </a> </td> <td><a class="action-edit" href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/aide-departementale-activ-emploi-pour-les-beneficiaires-du-rsa-dans-le-nord">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger"> <td class="cell-data cell-data--string"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> Attestation de comparabilité d\'un diplôme obtenu à </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> 75 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> 79 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> Mars 2018 </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> </a><a href="/admin/contract_types/dispositif-de-conversion-d-experience-en-titre">Dispositif de conversion d\'expérience en titre</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/attestation-de-comparabilite-d-un-diplome-obtenu-a-l-etranger">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/subvention-d-installation"> <td class="cell-data cell-data--string"> <a href="/admin/aids/subvention-d-installation" class="action-show"> Subvention d\'installation </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/subvention-d-installation" class="action-show"> 21 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/subvention-d-installation" class="action-show"> 34 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/subvention-d-installation" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/subvention-d-installation" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-creation-ou-reprise-d-entreprise">Aide à la création ou reprise d\'entreprise</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/subvention-d-installation" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/subvention-d-installation" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/subvention-d-installation" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/subvention-d-installation/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/subvention-d-installation">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/autres-aides-nationales-pour-la-mobilite"> <td class="cell-data cell-data--string"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> Autres aides nationales pour la mobilité </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> 44 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> 8 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-mobilite">Aide à la mobilité</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/autres-aides-nationales-pour-la-mobilite" class="action-show"> 3 filter </a> </td> <td><a class="action-edit" href="/admin/aids/autres-aides-nationales-pour-la-mobilite/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/autres-aides-nationales-pour-la-mobilite">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/erasmus-pour-jeunes-entrepreneurs"> <td class="cell-data cell-data--string"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> Erasmus pour Jeunes Entrepreneurs </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> 93 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> 0 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-creation-ou-reprise-d-entreprise">Aide à la création ou reprise d\'entreprise</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/erasmus-pour-jeunes-entrepreneurs" class="action-show"> 2 filter </a> </td> <td><a class="action-edit" href="/admin/aids/erasmus-pour-jeunes-entrepreneurs/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/erasmus-pour-jeunes-entrepreneurs">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi"> <td class="cell-data cell-data--string"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> Rémunération des formations de Pôle emploi (RFPE) </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> 52 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> 75 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> </a><a href="/admin/contract_types/dispositif-de-conversion-d-experience-en-titre">Dispositif de conversion d\'expérience en titre</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/rfpe-remuneration-des-formations-de-pole-emploi">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/aide-au-projet-initiative-jeune-pij"> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> Aide au Projet Initiative Jeune (PIJ) </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> 57 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> 0 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> </a><a href="/admin/contract_types/aide-a-la-creation-ou-reprise-d-entreprise">Aide à la création ou reprise d\'entreprise</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/aide-au-projet-initiative-jeune-pij" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/aide-au-projet-initiative-jeune-pij/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/aide-au-projet-initiative-jeune-pij">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/programme-reactivate"> <td class="cell-data cell-data--string"> <a href="/admin/aids/programme-reactivate" class="action-show"> Programme Reactivate </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/programme-reactivate" class="action-show"> 28 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/programme-reactivate" class="action-show"> 62 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/programme-reactivate" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/programme-reactivate" class="action-show"> </a><a href="/admin/contract_types/emploi-international">Emploi international</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/programme-reactivate" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/programme-reactivate" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/programme-reactivate" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/programme-reactivate/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/programme-reactivate">Supprimer</a></td> </tr> <tr class="js-table-row" tabindex="0" role="link" data-url="/admin/aids/formation-a-distance-sur-open-classrooms"> <td class="cell-data cell-data--string"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> Formation à distance sur Open Classrooms </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> 68 </a> </td> <td class="cell-data cell-data--number"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> 67 </a> </td> <td class="cell-data cell-data--string"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> </a> </td> <td class="cell-data cell-data--belongs-to"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> </a><a href="/admin/contract_types/dispositif-de-conversion-d-experience-en-titre">Dispositif de conversion d\'expérience en titre</a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> 0 need filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> 0 custom filter </a> </td> <td class="cell-data cell-data--has-many"> <a href="/admin/aids/formation-a-distance-sur-open-classrooms" class="action-show"> 1 filter </a> </td> <td><a class="action-edit" href="/admin/aids/formation-a-distance-sur-open-classrooms/edit">Modifier</a></td> <td><a class="text-color-red" data-confirm="Êtes-vous sûr ?" rel="nofollow" data-method="delete" href="/admin/aids/formation-a-distance-sur-open-classrooms">Supprimer</a></td> </tr> </tbody> </table>'
  end


  fixture(name: "french_arrondissement_input") do
    JSON.parse('
      {
        "version": "draft",
        "limit": 20,
        "attribution": "BAN",
        "type": "FeatureCollection",
        "query": "75020",
        "features": [
          {
            "geometry": {
              "coordinates": [
                2.399262,
                48.863656
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Pyrénées 75020 Paris",
              "type": "street",
              "x": 655946,
              "postcode": "75020",
              "importance": 0.4897,
              "score": 0.680881818181818,
              "city": "Paris",
              "id": "75120_7904_ef0889",
              "y": 6862750.5,
              "citycode": "75120",
              "name": "Rue des Pyrénées"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.410111,
                48.855346
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard Davout 75020 Paris",
              "type": "street",
              "x": 656717,
              "postcode": "75020",
              "importance": 0.4896,
              "score": 0.6808727272727272,
              "city": "Paris",
              "id": "75120_XXXX_db7b6d",
              "y": 6861862.5,
              "citycode": "75120",
              "name": "Boulevard Davout"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.400725,
                48.867691
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Avenue Gambetta 75020 Paris",
              "type": "street",
              "x": 656055,
              "postcode": "75020",
              "importance": 0.4772,
              "score": 0.6797454545454544,
              "city": "Paris",
              "id": "75120_XXXX_9e7154",
              "y": 6863268.5,
              "citycode": "75120",
              "name": "Avenue Gambetta"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.39613,
                48.854453
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard de Charonne 75020 Paris",
              "type": "street",
              "x": 655714.8,
              "postcode": "75020",
              "importance": 0.4678,
              "score": 0.678890909090909,
              "city": "Paris",
              "id": "75120_XXXX_5af377",
              "y": 6861752.4,
              "citycode": "75120",
              "name": "Boulevard de Charonne"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.408745,
                48.86958
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard Mortier 75020 Paris",
              "type": "street",
              "x": 656628.6,
              "postcode": "75020",
              "importance": 0.465,
              "score": 0.6786363636363635,
              "city": "Paris",
              "id": "75120_XXXX_9a862b",
              "y": 6863446,
              "citycode": "75120",
              "name": "Boulevard Mortier"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.400905,
                48.868963
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Pelleport 75020 Paris",
              "type": "street",
              "x": 656053,
              "postcode": "75020",
              "importance": 0.4585,
              "score": 0.6780454545454544,
              "city": "Paris",
              "id": "75120_7228_7c96f6",
              "y": 6863381.7,
              "citycode": "75120",
              "name": "Rue Pelleport"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.401499,
                48.85893
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de Bagnolet 75020 Paris",
              "type": "street",
              "x": 656088.1,
              "postcode": "75020",
              "importance": 0.458,
              "score": 0.6779999999999999,
              "city": "Paris",
              "id": "75120_0626_42aef0",
              "y": 6862265.8,
              "citycode": "75120",
              "name": "Rue de Bagnolet"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.390546,
                48.868814
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de Menilmontant 75020 Paris",
              "type": "street",
              "x": 655293,
              "postcode": "75020",
              "importance": 0.4534,
              "score": 0.6775818181818182,
              "city": "Paris",
              "id": "75120_6270_b7664c",
              "y": 6863371,
              "citycode": "75120",
              "name": "Rue de Menilmontant"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.390942,
                48.875382
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de Belleville 75020 Paris",
              "type": "street",
              "x": 655327.7,
              "postcode": "75020",
              "importance": 0.4531,
              "score": 0.6775545454545453,
              "city": "Paris",
              "id": "75120_0833_ec0c28",
              "y": 6864101.1,
              "citycode": "75120",
              "name": "Rue de Belleville"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.404322,
                48.852338
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue d\'Avron 75020 Paris",
              "type": "street",
              "x": 656289.7,
              "postcode": "75020",
              "importance": 0.452,
              "score": 0.6774545454545454,
              "city": "Paris",
              "id": "75120_XXXX_a0e278",
              "y": 6861531.2,
              "citycode": "75120",
              "name": "Rue d\'Avron"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.38627,
                48.864119
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard de Menilmontant 75020 Paris",
              "type": "street",
              "x": 654975.3,
              "postcode": "75020",
              "importance": 0.4463,
              "score": 0.6769363636363634,
              "city": "Paris",
              "id": "75120_XXXX_cfe14f",
              "y": 6862851.3,
              "citycode": "75120",
              "name": "Boulevard de Menilmontant"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.403565,
                48.871645
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Saint-Fargeau 75020 Paris",
              "type": "street",
              "x": 656257.9,
              "postcode": "75020",
              "importance": 0.4403,
              "score": 0.676390909090909,
              "city": "Paris",
              "id": "75120_XXXX_4662b9",
              "y": 6863687.7,
              "citycode": "75120",
              "name": "Rue Saint-Fargeau"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.397279,
                48.867612
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Villiers de l\'Isle Adam 75020 Paris",
              "type": "street",
              "x": 655785.9,
              "postcode": "75020",
              "importance": 0.4384,
              "score": 0.6762181818181817,
              "city": "Paris",
              "id": "75120_XXXX_2c1515",
              "y": 6863233.5,
              "citycode": "75120",
              "name": "Rue Villiers de l\'Isle Adam"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.397575,
                48.866827
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Orfila 75020 Paris",
              "type": "street",
              "x": 655806.9,
              "postcode": "75020",
              "importance": 0.4372,
              "score": 0.6761090909090908,
              "city": "Paris",
              "id": "75120_6924_66d4e9",
              "y": 6863146.1,
              "citycode": "75120",
              "name": "Rue Orfila"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.404286,
                48.851162
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Grands Champs 75020 Paris",
              "type": "street",
              "x": 656265.1,
              "postcode": "75020",
              "importance": 0.4351,
              "score": 0.6759181818181818,
              "city": "Paris",
              "id": "75120_4287_ba49cd",
              "y": 6861410.9,
              "citycode": "75120",
              "name": "Rue des Grands Champs"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.40143,
                48.855384
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue de la Réunion 75020 Paris",
              "type": "street",
              "x": 656070.8,
              "postcode": "75020",
              "importance": 0.4351,
              "score": 0.6759181818181818,
              "city": "Paris",
              "id": "75120_8180_5b2f94",
              "y": 6861861.9,
              "citycode": "75120",
              "name": "Rue de la Réunion"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.403194,
                48.856351
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Orteaux 75020 Paris",
              "type": "street",
              "x": 656210.3,
              "postcode": "75020",
              "importance": 0.4338,
              "score": 0.6757999999999998,
              "city": "Paris",
              "id": "75120_6958_ee42b1",
              "y": 6861978.1,
              "citycode": "75120",
              "name": "Rue des Orteaux"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.40395,
                48.872918
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue Haxo 75020 Paris",
              "type": "street",
              "x": 656279.7,
              "postcode": "75020",
              "importance": 0.4325,
              "score": 0.675681818181818,
              "city": "Paris",
              "id": "75120_4510_bebd6c",
              "y": 6863819.8,
              "citycode": "75120",
              "name": "Rue Haxo"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.406755,
                48.852637
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Rue des Maraîchers 75020 Paris",
              "type": "street",
              "x": 656468.5,
              "postcode": "75020",
              "importance": 0.4316,
              "score": 0.6755999999999999,
              "city": "Paris",
              "id": "75120_5985_63a756",
              "y": 6861563.1,
              "citycode": "75120",
              "name": "Rue des Maraîchers"
            }
          },
          {
            "geometry": {
              "coordinates": [
                2.379993,
                48.86982
              ],
              "type": "Point"
            },
            "type": "Feature",
            "properties": {
              "context": "75, Paris, Île-de-France",
              "label": "Boulevard de Belleville 75020 Paris",
              "type": "street",
              "x": 654519.8,
              "postcode": "75020",
              "importance": 0.4306,
              "score": 0.6755090909090908,
              "city": "Paris",
              "id": "75120_XXXX_f7eabc",
              "y": 6863488.8,
              "citycode": "75120",
              "name": "Boulevard de Belleville"
            }
          }
        ],
        "licence": "ODbL 1.0"
      }
    ')
  end

  fixture(name: "multiple_towns_per_postcode_json") do
    JSON.parse('
    {
      "type": "FeatureCollection",
      "limit": 20,
      "version": "draft",
      "licence": "ODbL 1.0",
      "attribution": "BAN",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "importance": 0.6466,
            "type": "municipality",
            "adm_weight": 4,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43157",
            "population": 18.8,
            "x": 769600,
            "y": 6438600,
            "name": "Le Puy-en-Velay",
            "citycode": "43157",
            "label": "Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.8769636363636364
          },
          "geometry": {
            "coordinates": [
              3.883955,
              45.043141
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.0867,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43089",
            "population": 3.6,
            "x": 767600,
            "y": 6438900,
            "name": "Espaly-Saint-Marcel",
            "citycode": "43089",
            "label": "Espaly-Saint-Marcel",
            "city": "Espaly-Saint-Marcel",
            "score": 0.8260636363636362
          },
          "geometry": {
            "coordinates": [
              3.858597,
              45.046041
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.0767,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43152",
            "population": 2.8,
            "x": 767600,
            "y": 6441500,
            "name": "Polignac",
            "citycode": "43152",
            "label": "Polignac",
            "city": "Polignac",
            "score": 0.8251545454545454
          },
          "geometry": {
            "coordinates": [
              3.858957,
              45.06945
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.075,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43045",
            "population": 0.4,
            "x": 765800,
            "y": 6437900,
            "name": "Ceyssac",
            "citycode": "43045",
            "label": "Ceyssac",
            "city": "Ceyssac",
            "score": 0.825
          },
          "geometry": {
            "coordinates": [
              3.835603,
              45.037211
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.075,
            "type": "municipality",
            "adm_weight": 1,
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43002",
            "population": 1.6,
            "x": 769600,
            "y": 6439400,
            "name": "Aiguilhe",
            "citycode": "43002",
            "label": "Aiguilhe",
            "city": "Aiguilhe",
            "score": 0.825
          },
          "geometry": {
            "coordinates": [
              3.884069,
              45.050344
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3792,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue Maréchal Foch",
            "id": "43157_XXXX_68a415",
            "x": 769840.5,
            "y": 6437684.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue Maréchal Foch 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6708363636363635
          },
          "geometry": {
            "coordinates": [
              3.886879,
              45.034876
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.359,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue Baptiste Marcet",
            "id": "43157_XXXX_e4846a",
            "x": 769815,
            "y": 6436476.6,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue Baptiste Marcet 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6689999999999999
          },
          "geometry": {
            "coordinates": [
              3.886383,
              45.024002
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3535,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Gambetta",
            "id": "43157_XXXX_47e921",
            "x": 769097.8,
            "y": 6438790,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Gambetta 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6684999999999999
          },
          "geometry": {
            "coordinates": [
              3.877604,
              45.044902
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3495,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Carnot",
            "id": "43157_XXXX_d211a5",
            "x": 769239.8,
            "y": 6438896.1,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Carnot 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6681363636363635
          },
          "geometry": {
            "coordinates": [
              3.879497,
              45.045753
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.347,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Saint-Louis",
            "id": "43157_XXXX_ac3fce",
            "x": 769362.8,
            "y": 6438553,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Saint-Louis 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6679090909090908
          },
          "geometry": {
            "coordinates": [
              3.880936,
              45.042742
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3446,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue du Val Vert",
            "id": "43157_XXXX_b9ec45",
            "x": 769659.5,
            "y": 6437321.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue du Val Vert 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.667690909090909
          },
          "geometry": {
            "coordinates": [
              3.884529,
              45.031626
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3377,
            "type": "street",
            "postcode": "43000",
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "id": "43157_XXXX_414a86",
            "x": 770521.1,
            "y": 6439104.2,
            "name": "Avenue des Belges",
            "citycode": "43157",
            "label": "Avenue des Belges 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6670636363636362,
            "alias": "route de brives"
          },
          "geometry": {
            "coordinates": [
              3.895725,
              45.047587
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3354,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Maréchal Fayolle",
            "id": "43157_XXXX_d84781",
            "x": 769847.5,
            "y": 6438505.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Maréchal Fayolle 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6668545454545454
          },
          "geometry": {
            "coordinates": [
              3.887085,
              45.042267
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3354,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Bertrand de Doue",
            "id": "43157_XXXX_273513",
            "x": 770576.5,
            "y": 6438707.7,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Bertrand de Doue 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6668545454545454
          },
          "geometry": {
            "coordinates": [
              3.896001,
              45.043812
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3346,
            "type": "street",
            "postcode": "43000",
            "name": "Place du Breuil",
            "id": "43157_XXXX_496c82",
            "x": 769559.9,
            "y": 6438477.6,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Place du Breuil 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6667818181818181
          },
          "geometry": {
            "coordinates": [
              3.883428,
              45.042043
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3297,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard de la République",
            "id": "43157_XXXX_f85cce",
            "x": 770103.3,
            "y": 6438751,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard de la République 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6663363636363635
          },
          "geometry": {
            "coordinates": [
              3.890368,
              45.04445
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3282,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue d\'Ours Mons",
            "id": "43157_XXXX_39f371",
            "x": 770484.7,
            "y": 6438266.4,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue d\'Ours Mons 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6661999999999999
          },
          "geometry": {
            "coordinates": [
              3.895142,
              45.040048
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3268,
            "type": "street",
            "postcode": "43000",
            "name": "Avenue Antonin Raffier",
            "id": "43157_XXXX_ad3a62",
            "x": 772173.2,
            "y": 6437756.9,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Avenue Antonin Raffier 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6660727272727273
          },
          "geometry": {
            "coordinates": [
              3.916509,
              45.035286
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.325,
            "type": "street",
            "postcode": "43000",
            "name": "Boulevard Maréchal Joffre",
            "id": "43157_XXXX_8eeef5",
            "x": 770337.3,
            "y": 6439134.9,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Boulevard Maréchal Joffre 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6659090909090908
          },
          "geometry": {
            "coordinates": [
              3.893395,
              45.047882
            ],
            "type": "Point"
          }
        },
        {
          "type": "Feature",
          "properties": {
            "importance": 0.3219,
            "type": "street",
            "postcode": "43000",
            "name": "Rue Pannessac",
            "id": "43157_1550_5151ab",
            "x": 769394.5,
            "y": 6438688.3,
            "context": "43, Haute-Loire, Auvergne-Rhône-Alpes (Auvergne)",
            "citycode": "43157",
            "label": "Rue Pannessac 43000 Le Puy-en-Velay",
            "city": "Le Puy-en-Velay",
            "score": 0.6656272727272727
          },
          "geometry": {
            "coordinates": [
              3.881358,
              45.043957
            ],
            "type": "Point"
          }
        }
      ],
      "query": "43000"
    }

      ')
  end  

end
