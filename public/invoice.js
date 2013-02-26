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
  
  var updatePrices = function() {
    $('.price').each(function(){
      var val = $(this).val();
      if (val < 0) {
        $(this).addClass('negative');
      }
      else {
        $(this).removeClass('negative');
      }
    });
  };
  
  var totalItems = function() {
    var gst = 0, total = 0, gstRate = 0.1;
    $('.price[contenteditable]', invTable).each(function(){
      var val = parseFloat($(this).text());
      
      if ($(this).hasClass('price') && isNaN(val)) {
        $(this).text('0.00');
        val = 0;
      }
      
      var name = $(this).closest('tr').find('.name').text();
      if (name.toLowerCase().indexOf('ex gst') >= 0) {
        gst += 0;
      }
      else {
        gst += (val * (gstRate / (1 + gstRate)));
      }
      
      total += val;
      $(this).text(val.toFixed(2));
    });
    
    $('.total').text(total.toFixed(2));
    
    $('.gst').not('.custom').text(gst.toFixed(2));
    if ($('.gst').hasClass('custom')) {
      gst = parseFloat($('.gst').text());
    }
    
    $('.subtotal').text((total - gst).toFixed(2));
    
    updatePrices();
  };
  
  $('[contenteditable]', invTable).blur(function(e){
    if ($(this).hasClass('gst')) {
      if ($(this).text() != '') {
        $(this).addClass('custom');
      }
      else {
        $(this).removeClass('custom');
      }
    }
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