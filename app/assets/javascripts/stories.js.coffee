# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready page:load', () ->

    site_script_token = () ->
        # initially set focus on first input box
        $('.token input').first().focus().select()

        # on change of one of the input boxes, capitalize input and set focus to next box (if possible)
        $('.token input').on('input', () ->
            $(this).val($(this).val().toUpperCase())
            $(this).parent().next().children().first().focus().select();
        )

        # on focus of an input box, mark the input
        $('.token input').click(() ->
            this.select()
        )

    # page specific javascript
    switch window.location.pathname
        when "/token" then site_script_token()
        else

)
