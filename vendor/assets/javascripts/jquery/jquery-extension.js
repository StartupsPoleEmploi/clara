$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^]*)').exec(window.location.href);
    if (results==null){
       return null;
    }
    else{
       return results[1] || 0;
    }
}

function _setBrowser() {
    var userAgent = navigator.userAgent.toLowerCase();
    // Figure out what browser is being used
    $.browser = {
        version: (userAgent.match(/.+(?:rv|it|ra|ie|me|ve)[\/: ]([\d.]+)/) || [])[1],
        chrome: /chrome/.test(userAgent),
        safari: /webkit/.test(userAgent) && !/chrome/.test(userAgent),
        opera: /opera/.test(userAgent),
        firefox: /firefox/.test(userAgent),
        msie: /msie/.test(userAgent) && !/opera/.test(userAgent),
        mozilla: /mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent),
        // webkit: $.browser.webkit,
        gecko: /[^like]{4} gecko/.test(userAgent),
        presto: /presto/.test(userAgent),
        xoom: /xoom/.test(userAgent),
        android: /android/.test(userAgent),
        androidVersion: (userAgent.match(/.+(?:android)[\/: ]([\d.]+)/) || [0, 0])[1],
        iphone: /iphone|ipod/.test(userAgent),
        iphoneVersion: (userAgent.match(/.+(?:iphone\ os)[\/: ]([\d_]+)/) || [0, 0])[1].toString().split('_').join('.'),
        ipad: /ipad/.test(userAgent),
        ipadVersion: (userAgent.match(/.+(?:cpu\ os)[\/: ]([\d_]+)/) || [0, 0])[1].toString().split('_').join('.'),
        blackberry: /blackberry/.test(userAgent),
        winMobile: /Windows\ Phone/.test(userAgent),
        winMobileVersion: (userAgent.match(/.+(?:windows\ phone\ os)[\/: ]([\d_]+)/) || [0, 0])[1]
    };
    jQuery.browser.mobile = ($.browser.iphone || $.browser.ipad || $.browser.android || $.browser.blackberry);
};
_setBrowser();
