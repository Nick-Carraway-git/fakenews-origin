if (location.pathname !== '/users/sign_up') {
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