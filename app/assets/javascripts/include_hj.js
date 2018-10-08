load_js_for_page([], function(){
  if (clara.hj_is_disabled) {
    $("script[src*='hotjar.com']").remove();    
    _.unset(window, 'hj');
  } else {
    if (_.get(window, 'hj')) {
      // ok, hotjar loaded, do nothing
    } else {
      //load hotjar
      if (_.get(window, 'clara.hotjar_id')) {
        (function(h,o,t,j,a,r){ h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)}; h._hjSettings={hjid:window.clara.hotjar_id,hjsv:5}; a=o.getElementsByTagName('head')[0]; r=o.createElement('script');r.async=1; r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv; a.appendChild(r); })(window,document,'//static.hotjar.com/c/hotjar-','.js?sv=');
      }
    }
  }
});
