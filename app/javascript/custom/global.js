document.addEventListener('DOMContentLoaded', function () {
  $('#year').text(new Date().getFullYear());
  $('.alert').fadeOut(6000);
  $('#myTable').dataTable({
    sScrollX: '100%',
  });
  $('#tableUser').dataTable({
    sScrollX: '100%',
  });
  $('#tableUserFeedbacks').dataTable({
    lengthMenu: [25, 50, 100],
  });
});
