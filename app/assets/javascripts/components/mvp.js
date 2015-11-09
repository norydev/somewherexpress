$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

// as found on http://davidlesches.com/blog/rails-nested-forms-using-jquery-and-simpleform
// with a few customisations
jQuery(function($) {
  return $(document).ready(function() {
    var nestedForm;
    if ($('.tracks_form').length) {

      // initialize autocomplete for tracks attributes :start_location & :end_location
      for (i=0; i<($('.tracks_form').length); i++) {
        initializeAutocomplete('competition_tracks_attributes_'+ i +'_start_location');
        initializeAutocomplete('competition_tracks_attributes_'+ i +'_end_location');
      }

      nestedForm = $('.tracks_form').last().clone();

      // remove empty-field if edit
      if ($('.tracks_form').length > 1) {
        $('.tracks_form').last().remove();
      }

      $(".destroy_track:first").remove();
      $('body').on('click', '.destroy_track', function(e) {
        return $(this).closest('.tracks_form').slideUp().remove();
      });
      return $('.add_track').click(function(e) {
        var formsOnPage, lastNestedForm, newNestedForm;
        e.preventDefault();
        lastNestedForm = $('.tracks_form').last();
        newNestedForm = $(nestedForm).clone();

        // lastNestedForm position + 1
        formsOnPage = parseInt(/[0-9]+/.exec(lastNestedForm.find('label').attr('for'))[0]) + 1;

        $(newNestedForm).find('label').each(function() {
          var newLabel, oldLabel;
          oldLabel = $(this).attr('for');
          newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_" + formsOnPage + "_");
          return $(this).attr('for', newLabel);
        });
        $(newNestedForm).find('select, input').each(function() {
          var newId, newName, oldId, oldName;
          oldId = $(this).attr('id');
          newId = oldId.replace(new RegExp(/_[0-9]+_/), "_" + formsOnPage + "_");
          $(this).attr('id', newId);
          oldName = $(this).attr('name');
          newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[" + formsOnPage + "]");
          return $(this).attr('name', newName);
        });
        $(newNestedForm).insertAfter(lastNestedForm);
        initializeAutocomplete('competition_tracks_attributes_'+ formsOnPage +'_start_location');
        return initializeAutocomplete('competition_tracks_attributes_'+ formsOnPage +'_end_location');
      });
    }
  });
});