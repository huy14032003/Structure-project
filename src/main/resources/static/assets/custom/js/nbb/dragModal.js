//Make the DIV element draggagle:
// dragElement(document.getElementById("mydiv"));
var body_view = document.getElementById("body_view");
var offsetWidth = body_view.clientWidth;
var offsetHeight = body_view.clientHeight;
function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "header")) {
    /* if present, the header is where you move the DIV from:*/
    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
  } else {
    /* otherwise, move the DIV from anywhere inside the DIV:*/
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
    // var x = elmnt.offsetLeft - pos1;
    // var y = elmnt.offsetTop - pos2;

    // var width = elmnt.offsetWidth;
    // var height = elmnt.offsetHeight;

    // var currentWidth = elmnt.offsetLeft + elmnt.offsetWidth;
    // var currentHeight = elmnt.offsetTop + elmnt.offsetHeight;

    // if(x >= 0 && currentWidth <= offsetWidth){
    // 	elmnt.style.left = x + "px";
    // } else if(x < 0) {
    //     elmnt.style.left = "0px";
    // } else if (currentWidth > offsetWidth) {
    //     elmnt.style.left = offsetWidth + "px";
    // }
    // if(y >= 0 && currentHeight <= offsetHeight){
    // 	elmnt.style.top = y + "px";
    // } else if (y < 0) {
    //     elmnt.style.top = "0px";
    // } else if(currentHeight > offsetHeight) {
    // 	elmnt.style.top = offsetHeight - height + "px";
    // }

    // if(width > elmnt.offsetWidth || height > elmnt.offsetHeight){
    //   elmnt.style.left = (elmnt.offsetLeft + pos1)+"px";
    //   elmnt.style.top = (elmnt.offsetTop + pos2)+ "px";
    // }
  }

  function closeDragElement() {
    /* stop moving when mouse button is released:*/
    document.onmouseup = null;
    document.onmousemove = null;
  }
}