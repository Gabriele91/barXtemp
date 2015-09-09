;(function () {
  window.onload = function () {
    // get image list
    var imageList = document.getElementById('imageList')
    // get elements
    var images = imageList.getElementsByTagName('img')
    // if have some images
    if (images && images.length) {
      // first id
      var imageCurrent = 0
      // hide all
      for ( var key = 0; key != images.length; ++key) {
        images[key].style.display = 'none'
      }
      // show first
      images[imageCurrent].style.display = 'block'
      // change image event
      imageList.onclick = function () {
        if (images) {
          images[imageCurrent].style.display = 'none'
          imageCurrent = (imageCurrent + 1) % images.length
          images[imageCurrent].style.display = 'block'
        }
      }
    }
  }
})()
