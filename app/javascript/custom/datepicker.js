document.addEventListener('DOMContentLoaded', function () {
  flatpickr('.dpicker', {
    enableTime: true,
    dateFormat: 'Y-m-d H:i',
    altInput: true,
    minDate: 'today',
    altFormat: 'F j, Y  H:i K',
    locale: 'fr',
  });
});
