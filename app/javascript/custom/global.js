window.addEventListener('DOMContentLoaded', (event) => {
  setActiveClass();
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
function setActiveClass() {
  navItems = document.querySelectorAll('.nav-link');
  navItems.forEach((item) => {
    toggleClass(item);
    item.addEventListener('click', () => {
      toggleClass(item);
    });
  });
}
function toggleClass(item) {
  let anchor_value = window.location.hash;
  hrefText = item.getAttribute('href');
  if (anchor_value === hrefText) {
    item.classList.add('active');
  } else {
    item.classList.remove('active');
  }
}
