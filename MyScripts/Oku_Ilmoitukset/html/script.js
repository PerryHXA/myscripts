var UIActive = false;
var opened = null;
var currentElement = null;
var acceptedCall = '';
var job = '';
var ustatus = null;
var firstname = '';
var lastname = '';
var id = 0;


var jobInfo = [];

function playClickSound() {
  var audio = document.getElementById("clickaudio");
  audio.volume = 0.1;
  audio.play();
}

function playAlertSound() {
  var audio = document.getElementById("alertaudio");
  audio.volume = 0.1;
  audio.play();
}


function sendCall(id, call, cool) {


  if (call.type == 'call') {

    var base = '    <div class="rgba-background clearfix colelem alert  call scale-up-right" id="call_' + id + '" data-x="' + call.coords[0] + '" data-y="' + call.coords[1] + '" data-z="' + call.coords[2] + '"><!-- column -->' +
      '     <div class="clearfix colelem" id="pu1231-4"><!-- group -->' +
      '      <div class="rounded-corners clearfix grpelem" id="u1447-4"><!-- content -->' +
      '       <p id="u1231-2">#' + id + '</p>' +
      '      </div>' +
      '      <div class="rounded-corners clearfix grpelem" id="u1233-4"><!-- content -->' +
      '       <p id="u1233-2">' + call.code + '</p>' +
      '      </div>' +
	  '      <br>' +
	  '      </br>' +
      '      <div class="clearfix grpelem" id="u1230-4"><!-- content -->' +
      '       <p>' + call.title + '</p>' +
      '      </div>' +
      '     </div>' +

      '<div class="infostore">';

    for (i = 0; i < Object.keys(call.extraInfo).length; i++) {
      base = base + '     <div class="clearfix colelem" id="pu1235"><!-- group -->' +
        '      <div class="grpelem" id="u1235"><i class="fas ' + call.extraInfo[i].icon + '"></i><!-- simple frame --></div>' +
        '      <div class="clearfix grpelem" id="u1236-4"><!-- content -->' +
        '       <p>' + String(call.extraInfo[i].info).toUpperCase() + '</p>' +
        '      </div>' +
        '      </div>';
    }


    base = base + '</div>' +


      '      <div class="clearfix grpelem" id="u4538-4"><!-- content -->' +
      '       <p>MATKALLA</p>' +


      '<div id="u4538-7">';
    for (i = 0; i < Object.keys(call.respondingUnits).length; i++) {
      base = base + '<div class="unit ' + call.respondingUnits[i].type + '">' + call.respondingUnits[i].unit + '</div>';
    }

    base = base + '</div>' +
      '      </div>' +

      '    </div>';


    $(base).appendTo("#pu392");

    setTimeout(function () {

      if (!UIActive) {
        $("#call_" + id).fadeOut();
         setTimeout(function () {
          $("#call_" + id).remove();
         }, 2000);
      }
    }, cool);


    playAlertSound();

  }
  else if (call.type == 'message') {


    var base = '<div class="rgba-background clearfix colelem alert scale-up-right message" id="call_' + id + '" data-phone="' + call.coords[0] + '" data-y="' + call.coords[1] + '" data-z="' + call.coords[2] + '"><!-- column -->' +

      '      <div class="rounded-corners clearfix grpelem" id="u1447-4"><!-- content -->' +
      '       <p id="u1447-2">#' + id + '</p>' +
      '      </div>' +
      '      <div class="rounded-corners clearfix grpelem" id="u1449-4"><!-- content -->' +
      '       <p id="u1449-2">VIESTI:</p>' +
      '      </div>' +
      '      <div class="clearfix grpelem" id="u1446-4"><!-- content -->' +
      '       <p>  Vastaanotettu</p>' +
      '      </div>' +

      '     <div class="rgba-background rounded-corners clearfix colelem" id="u1486-4"><!-- content -->' +
      '      <p id="u1486-2">' + call.message + '</p>' +
      '     </div>' +



      '<div id="u4538-7">';
    for (i = 0; i < Object.keys(call.respondingUnits).length; i++) {
      base = base + '<div class="unit ' + jobInfo[call.respondingUnits[i].type].color + '" id="unit_' + call.respondingUnits[i].unit + '">' + call.respondingUnits[i].unit + '</div>';
    }

    base = base + '</div>' +
      '      </div>' +

      '   </div>';


    $(base).appendTo("#pu392");

    setTimeout(function () {

     if (!UIActive) {
        $("#call_" + id).fadeOut();
         setTimeout(function () {
          $("#call_" + id).remove();
         }, 2000);
      }
    }, cool);


    playAlertSound();

  }

}


function populateCalls(calls) {
  for (const [key, value] of Object.entries(calls)) {


    for (i = 0; i < Object.keys(value.job).length; i++) {

      if (value.job[i] == job) {


        if (value.type == "call") {


          if (!$('#call_' + key).length) {


            var base = '    <div class="rgba-background clearfix colelem alert call scale-up-right" id="call_' + key + '" data-x="' + value.coords[0] + '" data-y="' + value.coords[1] + '" data-z="' + value.coords[2] + '"><!-- column -->' +
              '     <div class="clearfix colelem" id="pu1231-4"><!-- group -->' +
              '      <div class="rounded-corners clearfix grpelem" id="u1447-4"><!-- content -->' +
              '       <p id="u1231-2">#' + key + '</p>' +
              '      </div>' +
              '      <div class="rounded-corners clearfix grpelem" id="u1233-4"><!-- content -->' +
              '       <p id="u1233-2">' + value.code + '</p>' +
              '      </div>' +
              '      <div class="clearfix grpelem" id="u1230-4"><!-- content -->' +
              '       <p>' + value.title + '</p>' +
              '      </div>' +
              '     </div>' +

              '<div class="infostore">';

            for (i = 0; i < Object.keys(value.extraInfo).length; i++) {
              base = base + '     <div class="clearfix colelem" id="pu1235"><!-- group -->' +
                '      <div class="grpelem" id="u1235"><i class="fas ' + value.extraInfo[i].icon + '"></i><!-- simple frame --></div>' +
                '      <div class="clearfix grpelem" id="u1236-4"><!-- content -->' +
                '       <p>' + String(value.extraInfo[i].info).toUpperCase() + '</p>' +
                '      </div>' +
                '      </div>';
            }


            base = base + '</div>' +


              '      <div class="clearfix grpelem" id="u4538-4"><!-- content -->' +
              '       <p>MATKALLA</p>' +


              '<div id="u4538-7">';
            for (i = 0; i < Object.keys(value.respondingUnits).length; i++) {
              base = base + '<div class="unit ' + jobInfo[value.respondingUnits[i].type].color + '" id="unit_' + value.respondingUnits[i].unit + '">' + value.respondingUnits[i].unit + '</div>';
            }

            base = base + '</div>' +
              '      </div>' +


              '    </div>';


            $("#pu392").append(base);


          }


        }
        else if (value.type == "message") {


          if (!$('#call_' + key).length) {


            var base = '<div class="rgba-background clearfix colelem alert scale-up-right message" id="call_' + key + '" data-x="' + value.coords[0] + '" data-y="' + value.coords[1] + '" data-z="' + value.coords[2] + '"><!-- column -->' +

              '      <div class="rounded-corners clearfix grpelem" id="u1447-4"><!-- content -->' +
              '       <p id="u1447-2">#' + key + '</p>' +
              '      </div>' +
              '      <div class="rounded-corners clearfix grpelem" id="u1449-4"><!-- content -->' +
              '       <p id="u1449-2">VIESTI:</p>' +
              '      </div>' +
              '      <div class="clearfix grpelem" id="u1446-4"><!-- content -->' +
              '       <p>Vastaanotettu</p>' +
              '      </div>' +
              '     <div class="rgba-background rounded-corners clearfix colelem" id="u1486-4"><!-- content -->' +
              '      <p id="u1486-2">' + value.message + '</p>' +
              '     </div>' +




              '<div id="u4538-7">';
            for (i = 0; i < Object.keys(value.respondingUnits).length; i++) {
              base = base + '<div class="unit ' + jobInfo[value.respondingUnits[i].type].color + '" id="unit_' + value.respondingUnits[i].unit + '">' + value.respondingUnits[i].unit + '</div>';
            }

            base = base + '</div>' +
              '      </div>' +

              '   </div>';

            $("#pu392").append(base);


          }
        }
      }
    }

  }


  if (acceptedCall != '') {
    $(document).find('.alert').css('opacity', '0.5');
    $("#" + acceptedCall).css('opacity', '1.0');
  }


}


function populateUnits(units) {


  var location = '';
  var unitinfo = '';
  var unitstatus = '';
  var unitstatuslabel = '';


  for (const [key, value] of Object.entries(units)) {

    var base = '';

    if (jobInfo[value.job].column == 1) {
      location = '#u1129';
      unitinfo = jobInfo[value.job].color;
    }
    if (jobInfo[value.job].column == 2) {
      location = '#u1162';
      unitinfo = jobInfo[value.job].color;
    }
    if (jobInfo[value.job].column == 3) {
      location = '#u1195';
      unitinfo = jobInfo[value.job].color;
    }


    base = base + '<div class="rounded-corners unitgroup" id="u1408">' +
      '<i class="fas ' + value.type + ' vehiclesign"></i>' +
      '<div class="unitgrid">';

    for (i = 0; i < Object.keys(value.units).length; i++) {


      if (ustatus[value.units[i].id ] != null) {

        unitstatus = ustatus[value.units[i].id ];
        unitstatuslabel = ustatus[value.units[i].id ];
      }
      else {
        unitstatuslabel = 'Patrol';
      }


      base = base + '<div class="unit tooltip ' + unitinfo + ' ' + unitstatus + '">' + value.units[i].id +
        '<div class="tooltiptext">' + value.units[i].name + ' - ' + unitstatuslabel + '</div>' +
        '</div>';

    }

    base = base + '</div>' +
      '</div>';


    $(location).append(base);


  }


}


function OpenBase() {


  var base = '   <div class="clearfix grpelem " id="pu1129"><!-- group -->' +


    '<div class="rgba-background status" id="u1489"><!-- simple frame -->' +
    '   <div class="rounded-corners" id="u1490"><!-- simple frame --></div>' +
    '   <div class="clearfix" id="u1495-4"><!-- content -->' +
    '    <p>' + firstname.toUpperCase() + ' ' + lastname.toUpperCase() + '</p>' +
    '   </div>' +
    '   <div class="rounded-corners clearfix" id="u1498-4"><!-- content -->' +
    '    <p id="u1498-2">' + id + '</p>' +
    '   </div>' +
    '   <div id="u1501" onclick="toggleOffduty()"><i class="fas fa-power-off fa-lg"></i></div>' +
    '   <div id="u1504" onclick="togglecallblips()"><i class="fas fa-map-marked fa-lg"></i></div>' +
    '   <div id="u1507" onclick ="toggleAlerts()"><i class="fas fa-bell-slash fa-lg"></i></div>' +
    '   <div class="rounded-corners clearfix" id="u1516-4"><!-- content -->' +
    '    <p id="u1516-2">' + jobInfo[job].label.toUpperCase() + '</p>' +
    '   </div></div>' +

    '   </div>';


  $("#activeunits").html(base);

}

$(document).keyup(function (e) {
  if (e.keyCode === 27) {

    $.post('https://Oku_Ilmoitukset/close', JSON.stringify({}));
    $("#pu392").fadeOut("slow", function () {
      $("#pu392").html("").fadeIn();
    });
    $("#activeunits").fadeOut("slow", function () {

      $("#activeunits").html("").fadeIn();
    });
    UIActive = false;

  }


});


window.onclick = function (event) {

  var element = null;

  playClickSound();

  if ($(event.target).parents('.alert').length) {
    element = $(event.target).parents('.alert')[0];

  }
  else if ($(event.target).hasClass("alert")) {

    element = event.target;
  }


  if (element != null) {

    if ($(element).hasClass('call')) {
      if (element.style.height != '150px') {

        $(element).animate({
            height: 150
          },
          300, 'swing');


      }
      else {
        $(element).animate({
            height: 60
          },
          300, 'swing');
      }
    }
    else {

      if (element.style.height != '150px') {

        $(element).animate({
            height: 150
          },
          300, 'swing');


      }
      else {
        $(element).animate({
            height: 80
          },
          300, 'swing');
      }

    }

  }


  if (opened != null) {
    opened.style.display = "none";
    opened.remove();
    opened = null;
  }

}


function forwardCall(num) {


  for (const [key, value] of Object.entries(jobInfo)) {
    if (value.column == num) {
      $.post('https://Oku_Ilmoitukset/forwardCall', JSON.stringify({
        id: currentElement.id,
        job: key
      }));
    }
  }


}

function copyNumber() {

  const el = document.createElement('textarea');
  el.value = currentElement.dataset.phone;
  document.body.append(el);
  el.select();
  document.execCommand("copy");
  document.body.removeChild(el);
  $.post('https://Oku_Ilmoitukset/copynumber', JSON.stringify({}));
}

function toggleOffduty() {

  $.post('https://Oku_Ilmoitukset/toggleoffduty', JSON.stringify({}));

}

function togglecallblips() {
  $.post('https://Oku_Ilmoitukset/togglecallblips', JSON.stringify({}));
}

function toggleUnitBlips() {
  $.post('https://Oku_Ilmoitukset/toggleunitblips', JSON.stringify({}));
}

function toggleAlerts() {

  $.post('https://Oku_Ilmoitukset/togglealerts', JSON.stringify({}));

}

function changeToBusy() {
  $.post('https://Oku_Ilmoitukset/updatestatus', JSON.stringify({
    id: id,
    status: 'Busy'
  }));
}

function changeToPatrol() {
  $.post('https://Oku_Ilmoitukset/updatestatus', JSON.stringify({
    id: id,
    status: null
  }));
}

function dismissCall() {

  $(document).find('.alert').css('opacity', '1.0');
  acceptedCall = '';
  $.post('https://Oku_Ilmoitukset/dismissCall', JSON.stringify({
    id: currentElement.id
  }));

  $(currentElement).find("#unit_" + id).remove();

  $.post('https://Oku_Ilmoitukset/updatestatus', JSON.stringify({
    id: id,
    status: null
  }));
}

function removeCall() {

  $(currentElement).fadeOut();
  $.post('https://Oku_Ilmoitukset/removeCall', JSON.stringify({
    id: currentElement.id
  }));


}

function acceptCall() {

  $(document).find('.alert').css('opacity', '0.5');
  $(currentElement).css('opacity', '1.0');
  acceptedCall = currentElement.id;
  $.post('https://Oku_Ilmoitukset/acceptCall', JSON.stringify({
    id: currentElement.id,
    x: currentElement.dataset.x,
    y: currentElement.dataset.y,
    z: currentElement.dataset.z
  }));


  $(currentElement).find("#u4538-7").append('<div class="unit ' + jobInfo[job].color + '" id="unit_' + id + '">' + id + '</div>');

  $.post('https://Oku_Ilmoitukset/sendnotice', JSON.stringify({
    caller: currentElement.dataset.caller
  }));
  $.post('https://Oku_Ilmoitukset/updatestatus', JSON.stringify({
    id: id,
    status: 'Reacting'
  }));

}

function requestBackup() {

  var col = currentElement.dataset.column;


  for (const [key, value] of Object.entries(jobInfo)) {
    if (value.column == col) {
      $.post('https://Oku_Ilmoitukset/reqbackup', JSON.stringify({
        job: key,
        requester: jobInfo[job].label,
        firstname: firstname,
        lastname: lastname
      }));
    }
  }
}


window.oncontextmenu = function (event) {
  if (opened != null) {
    opened.style.display = "none";
    opened.remove();
    opened = null;
  }

  var columnMenu = false
  var statusMenu = false
  var element = null;

  if ($(event.target).parents('.column').length) {
    element = $(event.target).parents('.column')[0];
    columnMenu = true;
  }
  else if ($(event.target).hasClass("column")) {

    element = event.target;
    columnMenu = true;
  }

  if ($(event.target).parents('.status').length) {
    element = $(event.target).parents('.status')[0];
    statusMenu = true;
  }
  else if ($(event.target).hasClass("status")) {

    element = event.target;
    statusMenu = true;
  }

  if ($(event.target).parents('.alert').length) {
    element = $(event.target).parents('.alert')[0];

  }
  else if ($(event.target).hasClass("alert")) {

    element = event.target;
  }

  if (element != null) {

    currentElement = element;

    var html = '<div id="dropdown" class="dropdown-content">';


    if (columnMenu) {

      var col = currentElement.dataset.column;

      if (jobInfo[job].canRequestLocalBackup && col == jobInfo[job].column) {
        html = html + '    <a onclick="requestBackup()">Pyydä apua</a>';
      }
      if (jobInfo[job].canRequestOtherJobBackup && col != jobInfo[job].column) {
        html = html + '    <a onclick="requestBackup()">Pyydä apua</a>';
      }


    }
    else if (statusMenu) {

      html = html + '    <a onclick="changeToBusy()">Vaihda kiireiseksi</a>';
      html = html + '    <a onclick="changeToPatrol()">Vaida </a>';


    }
    else {
      if (acceptedCall == '') {
        html = html + '    <a onclick="acceptCall()">Hyväksy tehtävä</a>';
        if (jobInfo[job].canRemoveCall) {
          html = html + '    <a onclick="removeCall()">Poista tehtävä</a>';
        }

      }

      if (acceptedCall != '' && acceptedCall == $(element).attr('id')) {
        html = html + '    <a onclick="dismissCall()">Hylkää tehtävä</a>';
      }


      for (const [key, value] of Object.entries(jobInfo)) {
        if (key != job && jobInfo[job].forwardCall) {
          html = html + '    <a onclick="forwardCall(' + value.column + ')">Siirrä ' + value.label + '</a>';
        }
      }


    }


    html = html + '  </div>';

    $("#pu392").append(html);

    var dropdown = document.getElementById("dropdown");
    dropdown.style.display = "block";

    var rect = element.getBoundingClientRect();

    if (columnMenu) {
      dropdown.style.top = rect.top;
    }
    else {
      dropdown.style.top = rect.top + (rect.bottom - rect.top);
    }

    dropdown.style.right = 1920 - rect.right;
    dropdown.classList.add("active");


    opened = dropdown;

  }


}


window.addEventListener('message', function (event) {

  var edata = event.data;

  if (edata.type == "Init") {

    firstname = edata.firstname;
    lastname = edata.lastname;

    jobInfo = edata.jobInfo;

  }
  if (edata.type == "call") {
    sendCall(edata.id, edata.call, edata.cooldown);
  }
  if (edata.type == "open") {

    UIActive = true;
    job = edata.job;
    id = edata.id;
    ustatus = edata.ustatus;


    OpenBase();
    populateUnits(edata.units)
    populateCalls(edata.calls)
  }

  $("#u392").click(function () {

    document.getElementById("myDropdown").classList.toggle("show");
  });


});