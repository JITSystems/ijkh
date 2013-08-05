// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
        var placeEdit = function(){
        var ValueCheck = $('#place_edit_button').val();
        if (ValueCheck == 'Редактировать'){
            $('#place_info_container').fadeOut('fast',function(){
                $('#place_edit_container').fadeIn('slow');
                $('#place_edit_button').val('Сохранить');
                $('#place_edit_button').html('Сохранить');
                $('#place_edit_button').prop('type','submit');
                $('#place_edit_button').prop('onclick','');
                return false;
            })
        }
        else {
            $('#place_edit_container').fadeOut('fast',function(){
                $('#place_info_container').fadeIn('slow');
                $('#place_edit_button').val('Редактировать');
                $('#place_edit_button').html('Редактировать');
                $('#place_edit_button').prop('type','button');
                $('#place_edit_button').prop('onclick','placeEdit();');
            })
        }
        
    }