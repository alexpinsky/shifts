$(document).ready(function() {
  initTimePickers();
  var date = new Date();
  var d = date.getDate();
  var m = date.getMonth();
  var y = date.getFullYear();
  var work_place_id = $('#calendar').data("work-place")
  
  var calendar = $('#calendar').fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'resourceDay,resourceWeek,resourceMonth'
    },
    defaultView: 'resourceWeek',
    firstDay: 1,  
    editable: true,
    selectable: true,
    minTime: 8,
    maxTime:16,
    selectHelper: true,
    resources: /work_places/ + work_place_id + "/roles",
    events: [
      {
        title: 'Lunch 12.15-14.45',
        start: new Date(y, m, d, 12, 15),
        end: new Date(y, m, d, 14, 45),
        allDay: false,
        resource: ['resource1','resource2']
      },        
      {
        title: 'Meeting from this day to this +4',
        start: new Date(y, m, d, 10, 30),
        end: new Date(y, m, d+4, 11, 00),
        allDay: false,
        resource: 'resource1'
      },
      {
        title: 'Meeting 11.00',
        start: new Date(y, m-2, d, 11, 00),
        allDay: true,
        resource: 'resource2'
      },
      {
        title: 'Lunch 12-14',
        start: new Date(y, m, d, 12, 0),
        end: new Date(y, m, d, 14, 0),
        allDay: false,
        resource: 'resource1'
      }   
    ],
    select: function(start, end, allDay, jsEvent, view, resource) {
      $.ajax({
        url: "/work_places/" + work_place_id + "/shifts/new",
        data: { role_id: resource.id },
        datatype: 'html',
        success: function(html_response){
          var new_shift_modal = $("#new_shift");
          new_shift_modal.find(".modal-body").html(html_response);
          new_shift_modal.modal();
          // clear the current calender - fix for calendar duplication
          $('#calendar').html('');
        }
      });
    },
    resourceRender: function(resource, element, view) {
      // this is triggered when the resource is rendered, just like eventRender
    },
    eventDrop: function( event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view ) { 
      alert('event moved to '+event.start+' to '+event.resource);
    },
    eventResize: function( event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view ) { 
      alert('event was resized, new endtime: '+event.end);
    },
    eventClick: function ( event, jsEvent, view )  {
      alert('event '+event.title+' was left clicked');
    },
    eventRender: function( event, element, view ) { 

    },
    windowResize: function( view ) {
      calendar.fullCalendar('option', 'height', $(window).height() - 40);
    }
  });
});