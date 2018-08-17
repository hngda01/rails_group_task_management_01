$(document).ready(function(){
  $("a#addbut").click(function(){
    var next_value = $("#child_fields li").length - 1;
    $('li#add-date')
      .append(
        '<li><label for="task_subtasks_attributes_' +
          next_value + '_content">Content </label><input name="task[subtasks_attributes][' +
          next_value + '][content]" ' + 'id="task_subtasks_attributes_' +
          next_value + '_content" type="text"></li>'
      );
  });
});

$(function () {
    $('#contact-list').searchable({
      searchField: '#contact-list-search',
      selector: 'li',
      childSelector: '.name',
      show: function( elem ) {
        elem.slideDown(100);
      },
      hide: function( elem ) {
        elem.slideUp( 100 );
      }
    })
  });

var t = 0;

function myFunction(id) {
  t = id;
  var x = document.getElementById('user-div');
    if (x.style.display === 'inline') {
        x.style.display = 'none';
    } else {
        x.style.display = 'inline';
    }
}

function alert_link(id,name) {
  var xhttp = new XMLHttpRequest();
  var url = 'http://0.0.0.0:3000/en/add_user_subtask?subtask[id]='+t+'&subtask[user_id]='+id;
  xhttp.open('GET', url, true);
  xhttp.send();
  var x = document.getElementById('user-div');
  x.style.display = 'none';
  var button = document.getElementById('button'+t);
  button.value = name;
}

function change_status(subtask_id){
  var e = document.getElementById(subtask_id);
  var selected_value = e.options[e.selectedIndex].value;
  var xhttp = new XMLHttpRequest();
  var url = 'http://0.0.0.0:3000/en/change_subtask?subtask[id]='+subtask_id+'&subtask[status]='+selected_value;
  xhttp.open('GET', url, true);
  xhttp.send();
}

function estimate(ele){
  if(event.key === 'Enter') {
      // alert("value: "+ele.value+" sub: "+ele.name);
      var xhttp = new XMLHttpRequest();
      var url = 'http://0.0.0.0:3000/en/estimate?subtask[id]='+ele.name+'&subtask[estimate]='+ele.value;
      xhttp.open('GET', url, true);
      xhttp.send();
    }
}
