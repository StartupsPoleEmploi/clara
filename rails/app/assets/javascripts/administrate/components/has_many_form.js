$(function() {
  $(".field-unit--has-many select").selectize({ sortField: 'text', placeholder: "Vous pouvez sélectionner des items", onChange: function(){if (window.detect_selectize_change) {detect_selectize_change()}} });
});
