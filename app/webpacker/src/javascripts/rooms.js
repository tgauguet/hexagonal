window.enableEndDate = () => {
  const inputs = document.getElementsByClassName('dateinput')
  const start = inputs[0]
  const end = inputs[1]

  end.disabled = start.value ? false : true
}

window.showFormBtn = () => {
  const cta = document.getElementById('form-cta');
  const checkedBoxesLen = document.querySelectorAll('input[type=checkbox]:checked').length;
  document.getElementById('room-count').innerHTML = checkedBoxesLen;
  document.getElementById('room-plural').innerHTML = checkedBoxesLen > 1 ? 'S' : ' ';

  if (checkedBoxesLen > 0)
    cta.style.marginLeft = "0px";
  else
    cta.style.marginLeft = "-9999px";
}

window.showFilters = () => {
  const parentDiv = document.getElementById('filters-box');
  parentDiv.style.height = '5.9em';
}
