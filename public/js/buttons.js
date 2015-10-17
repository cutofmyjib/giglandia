$(document).ready(function() {
  faveButton();
});

function faveButton(){
  $('.favebands').on('click', '.favebutton', function(e){
    e.preventDefault();

    var bandId = $('.favebutton.plus').data('band');
    var request = $.ajax({
      url: "/bands/" + bandId + "/follow",
      type: "POST",
      dataType: "json"
    });//end ajax

    request.done(function(response){
      if(response.status){
        $('.favebutton.plus').addClass('hidden');
        $('.favebutton.minus').removeClass('hidden');
      } else {
        $('.favebutton.plus').removeClass('hidden');
        $('.favebutton.minus').addClass('hidden');
      }
    });//end done
  });
}
