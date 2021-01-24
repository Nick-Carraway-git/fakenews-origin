if( document.URL.match('/boardrooms/') ) {
  (function() {
    if( window.localStorage ) {
      if( !localStorage.getItem('first') ) {
        localStorage['first'] = true;
        window.location.reload();
      }
      else
        localStorage.removeItem('first');
      }
  })();
}
