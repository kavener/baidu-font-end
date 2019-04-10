// 外联
const para = document.querySelector('p');

para.addEventListener('click', updateName)
function updateName() {
    let name = prompt("input new line");
    para.textContent = name;
}