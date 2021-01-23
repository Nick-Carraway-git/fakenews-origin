if (location.pathname !== '/users/sign_up') {
  if (location.pathname !== '/users/password') {
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
}}
