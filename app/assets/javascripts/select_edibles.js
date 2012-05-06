  $(function() {
    function add_input( item ) {
      $('<input />').attr({'type':'hidden', 'name':'food_items[]', 'value':item.id})
                        .appendTo('#food-items');
    }

    function log( message ) {
      $( "<div/>" ).text( message ).prependTo( "#log" );
      $( "#log" ).scrollTop( 0 );
    }

    $( "#food_item" ).autocomplete({
      source: function( request, response ) {
        $.ajax({
          url: "http://localhost:3000/food_items.json",
          dataType: "json",
          data: {
            maxRows: 12,
            prefix: request.term
          },
          success: function( data ) {
            response( $.map( data, function( item ) {
              return {
                label: item.name,
                id: item.id,
                value: item.name
              }
            }));
          }
        });
      },
      minLength: 1,
      select: function( event, ui ) {
        add_input(ui.item);
        log( ui.item ?
          ui.item.label :
          "Nothing selected, input was " + this.value);
      },
      open: function() {
        $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      },
      close: function() {
        $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      }
    });
  });
