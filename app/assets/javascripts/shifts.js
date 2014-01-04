$(document).ready(function() {
  var date = new Date();
  var d = date.getDate();
  var m = date.getMonth();
  var y = date.getFullYear();
  var workplace_id = $('#calendar').data("work-place")
  
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
    resources: /workplaces/ + workplace_id + "/roles",
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
        url: "/workplaces/" + workplace_id + "/shifts/new.js",
        data: { 
          role_id: resource.id,
          container_id: "new_shift",
          start_time: start, 
          end_time: end
        },
        datatype: 'script'
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