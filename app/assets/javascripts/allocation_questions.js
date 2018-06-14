$(document).on('ready', function() {
  if ($( 'body' ).hasClass('allocation_questions', 'new' )) {

    $('.js-pnotify--ARE_ASP').click(function() {
       PNotify.removeAll();
       new PNotify({
        title: 'ARE / ASP',
        type: 'info',
        buttons:{
          sticker: false,
        },
        text: "Allocation d'Aide au Retour à l'Emploi, versée par Pôle emploi si vous avez travaillé au moins 122 jours dans les 28 derniers mois. \n\nASP : Allocation de Sécurisation Professionnelle, versée par Pôle emploi lorsque vous êtes en Contrat de Sécurisation Professionnelle (CSP), suite à un licenciement économique"
      });
    });

    $('.js-pnotify--ASS_AER_ATA_APS_AS-FNE').click(function() {
      PNotify.removeAll();
      new PNotify({
        title: 'ASS / AER / ATA / APS / AS-FNE',
        type: 'info',
        buttons:{
          sticker: false,
        },
        text: '' +
          "ASS : Allocation de Solidarité Spécifique, versée par Pôle emploi lorsque l'ARE prend fin." +
          "\n\nAER/AS-FNE : Allocation Equivalent Retraite, Allocation Spéciale du Fonds National de l'Emploi, versées soit lorsque vous avez le nombre de trimestres requis pour avoir une retraite à taux plein, soit lorsque vous avez atteint l'âge de la retraite" +
          "\n\nATA : Allocation Temporaire d'Attente, versée par Pôle emploi si vous étiez salarié(e) expatrié(e), apatride, détenu(e) liberé(e), bénéficiaire de la protection subsidiaire" +
          "\n\nAPS : Allocation de Professionnalisation et de Solidarité, versée par Pôle emploi lorsque vous êtes intermittent du spectacle"
      });
    });

    $('.js-pnotify--RPS_RFPA_RFF_pensionretraite').click(function() {
      PNotify.removeAll();
      new PNotify({
        title: 'RPS / RFPE / RFF / pension de retraite',
        type: 'info',
        buttons:{
          sticker: false,
        },
        text: '' +
          "Rémunération Publique des Stagiaires, Rémunération de Formation Pôle emploi, Rémunération de Fin de Formation, versées lorsque vous êtes en formation professionnelle. " +
          "\n\nPension de retraite : versée par la Caisse nationale d'Assurance vieillesse (CNAV) lorsque vous avez atteint l'âge légal de la retraite et que vous avez validé au moins un trimestre en tant que salarié."
      });
    });

    $('.js-pnotify--RSA').click(function() {
      PNotify.removeAll();
      new PNotify({
        title: 'RSA',
        type: 'info',
        buttons:{
          sticker: false,
        },
        text: '' +
          "Revenu de Solidarité Active, versé par la Caisse d'Allocations Familiales (CAF)"
      });
    });

    $('.js-pnotify--AAH').click(function() {
      PNotify.removeAll();
      new PNotify({
        title: 'AAH',
        type: 'info',
        buttons:{
          sticker: false,
        },
        text: '' +
          "Allocation aux Adultes Handicapés, versée par la MDPH lorsque vous portez un handicap"
      });
    });

  }
});
