$(document).ready(function(){
  var invTable = $('#invoice-table tbody');
  
  $('.row-button.add').click(function(e){
    e.preventDefault();
    var row = invTable.children('tr').first();
    var clone = row.clone(true);
    clone.find('.name[contenteditable]').text('Item');
    clone.find('.price[contenteditable]').text('0.00');
    clone.appendTo(invTable);
    totalItems();
  });
  
  $('.row-button.remove').click(function(e){
    e.preventDefault();
    if (invTable.children('tr').length > 1) {
      $(this).closest('tr').remove();
    }
    totalItems();
  });
  
  var totalItems = function() {
    var total = 0;
    $('.price[contenteditable]', invTable).each(function(){
      var val = parseFloat($(this).text());
      total += val;
      $(this).text(val.toFixed(2));
    });
    $('.subtotal').text(total.toFixed(2));
    $('.gst').text((total * 0.1).toFixed(2));
    $('.total').text((total * 1.1).toFixed(2));
  };
  
  $('[contenteditable]', invTable).blur(function(e){
    totalItems();
  });
  
  $(".datepicker").datepicker({
    dateFormat: 'DD, d MM yy',
    showOn: "button",
    onSelect: function(dateText, inst) {
      var internalDate = [
        inst.selectedYear,
        inst.selectedMonth,
        inst.selectedDay
      ].join('-');
      
      $(this).parent().find("[contenteditable=false]").attr('data-internaldate', internalDate).focus().html(dateText).blur();
      
      if (!!$(this).attr('data-chain')) {
        var chainParts = $(this).attr('data-chain').split('|');
        for (var i in chainParts) {
          var bits = chainParts[i].split(',');
          
          var newDate = $(this).datepicker('getDate');
          if (newDate) {
            newDate.setDate(newDate.getDate() + +(bits[1]));
          }
          
          var target = $('#' + bits[0]);
          
          target
            .datepicker("option", "minDate", newDate)
            .datepicker("setDate", newDate);
          var dpDate = target.val();
          target.parent().find("[contenteditable=false]").text(dpDate);
        }
      }
    }
  });
});