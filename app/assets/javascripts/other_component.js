_.set(window, 'clara.other_component',

	function other_component(root_element){

    function $d(selector) {
      return $(root_element + ' ' + selector);
    }

    if(
      $(root_element + ' input#val_harki').length && 
      $(root_element + ' input#val_detenu').length && 
      $(root_element + ' input#val_pi').length && 
      $(root_element + ' input#val_handicap').length && 
      $(root_element + ' input#none').length)
      {return true;}
      

      
    return false;
  }


);
