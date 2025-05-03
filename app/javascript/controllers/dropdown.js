document.addEventListener('DOMContentLoaded', () => {
  const button = document.querySelector('.buttonfilter');
  const dropdown = button.querySelector('.dropdown-menu');

  button.addEventListener('click', (e) => {
    e.stopPropagation();
    dropdown.classList.toggle('show');
  });

  document.addEventListener('click', () => {
    dropdown.classList.remove('show');
  });
});
