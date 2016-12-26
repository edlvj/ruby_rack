$( document ).ready(function() {
  $('#welcome').openModal();
  $(".container").hide();
  
  $( "#start" ).click(function() {
  $.ajax({
    url: '/start',
    type: 'GET',
    success: function (data) {
      if(data == true)
         $(".container").show();
         $('#welcome').closeModal(); 
         $("#score").hide();
   }
  }); 
 });
  
  $( "#check" ).click(function() {
    $.ajax({
        url: '/match',
        type: 'POST',
        data: { code: $('#code').val() },
        success: function (data) {
      
          if(data == true) {
            $(".container").hide();
            result('You Win !!!'); }
          else if(data == false) {
            $(".container").hide();
            result('You Loose');
          } else {
            $("#result").text(data);  
          }    
      }
    }); 
  });

  $( "#hint" ).click(function() {
    $.ajax({
        url: '/hint',
        type: 'GET',
        success: function (data) {
          $("#hint_result").text(data); 
        }
    }); 
  });

$( "#save" ).click(function() {
    $.ajax({
        url: '/save_score',
        type: 'POST',
        data: { username: $('#username').val()},
        success: function (data) {
          $('#status').text( "Results List." ); 
          $('#save_input').hide();
          $("#save").hide();
          $("#score").show();
        },
        complete:function(){
            $.ajax({
              url: '/score',
              type: 'GET',
              success: function (data) {
                var res = '';  
                for(var i = 0; i < data.length; i++) {
                    res += '<tr><td>' + data[i].user + '</td><td>' + data[i].attempts + '</td><tr>';
                }
                $("#score_list").append(res);
              }
            });
        }    
    });
}); 

$( "#restart" ).click(function() {
    $.ajax({
       url: '/start',
       type: 'GET',
       success: function (data) {
        if(data == true)
          $(".container").show();
          $('#alert').closeModal(); 
          $('#code').val("");
          $("#result").text(""); 
          $("#hint_result").text(""); 
       }
    });  
});  

$("#code").keypress(function(e) {  
    var input = $(this).val().length;
    var key = e.charCode || e.keyCode || 0;                     
    if (key >= 48 && key <= 54 && input < 4) {
        return;
    } else {
        e.preventDefault();
    }
});

$("#username").keypress(function(e) {  
    var input = $(this).val().length;
    
    if (input < 10) {
        return;
    } else {
        e.preventDefault();
    }
});

});

function result(text) {
    $('#status').text( text );
    $('#alert').openModal();
} 