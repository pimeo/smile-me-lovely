var Vector = function(x, y) {
    this.x = x;
    this.y = y;
}
Vector.prototype = {isub: function(other) {
        this.x -= other.x;
        this.y -= other.y;
        return this;
    },sub: function(other) {
        return new Vector(this.x - other.x, this.y - other.y);
    },iadd: function(other) {
        this.x += other.x;
        this.y += other.y;
        return this;
    },add: function(other) {
        return new Vector(this.x + other.x, this.y + other.y);
    },imul: function(scalar) {
        this.x *= scalar;
        this.y *= scalar;
        return this;
    },mul: function(scalar) {
        return new Vector(this.x * scalar, this.y * scalar)
    },idiv: function(scalar) {
        this.x /= scalar;
        this.y /= scalar;
        return this;
    },div: function(scalar) {
        return new Vector(this.x / scalar, this.y / scalar)
    },normalized: function() {
        var x = this.x, y = this.y;
        var length = Math.sqrt(x * x + y * y);
        if (length > 0) {
            return new Vector(x / length, y / length);
        } 
        else {
            return new Vector(0, 0);
        }
    },normalize: function() {
        var x = this.x, y = this.y;
        var length = Math.sqrt(x * x + y * y);
        if (length > 0) {
            this.x = x / length;
            this.y = y / length;
        }
        return this;
    },length: function() {
        return Math.sqrt(this.x * this.x + this.y * this.y);
    },distance: function(other) {
        var x = this.x - other.x;
        var y = this.y - other.y;
        return Math.sqrt(x * x + y * y);
    },copy: function() {
        return new Vector(this.x, this.y);
    },zero: function() {
        this.x = 0;
        this.y = 0;
    },validate: function() {
        if (isNaN(this.x + this.y)) {
            this.x = 0;
            this.y = 0;
        }
    }}
var Particle = function(canvas) {
    var initial_speed = 1;
    var speed_limit = 4;
    var bounce_damping = 0.5;
    this.acceleration = new Vector(0, 0);
    this.velocity = new Vector(Math.random() * initial_speed - initial_speed * 0.5, Math.random() * initial_speed - initial_speed * 0.5)
    this.position = new Vector(Math.random() * canvas.width, Math.random() * canvas.height)
    this.step = function() {
        this.acceleration.validate();
        this.velocity.iadd(this.acceleration);
        speed = this.velocity.length();
        if (speed > speed_limit) {
            this.velocity.idiv(speed / speed_limit);
        }
        this.position.iadd(this.velocity);
        this.acceleration.zero();
        if (this.position.x < 0) {
            this.position.x = 0;
            this.velocity.x *= -bounce_damping;
        } 
        else if (this.position.x > canvas.width) {
            this.position.x = canvas.width;
            this.velocity.x *= -bounce_damping;
        }
        if (this.position.y < 0) {
            this.position.y = 0;
            this.velocity.y *= -bounce_damping;
        } 
        else if (this.position.y > canvas.height) {
            this.position.y = canvas.height;
            this.velocity.y *= -bounce_damping;
        }
    }
    this.draw = function(context) {
        context.beginPath();
        context.arc(this.position.x, this.position.y, 2.5, 0, Math.PI * 2, false);
        context.fill();
    }
}
var System = function(amount, milliseconds) {
    var factor = 9;
    var min_proximity = 4;
    var canvas = $('#particles')[0];
    var interval = null;
    var context;
    if (canvas && canvas.getContext) {
        var context = canvas.getContext('2d');
        var particles = [];
        for (var i = 0; i < amount; i++) {
            particles.push(new Particle(canvas));
        }
        var toggle = $('<div class="switch button">off</div>').insertAfter('#particles').click(function() {
            if (interval) {
                $.cookie('particles', 'off', {expires: new Date('Jan 1 2020')});
                stop();
            } 
            else {
                $.cookie('particles', 'on', {expires: new Date('Jan 1 2020')});
                start(milliseconds);
            }
        });
        this.ready = true;
    }
    step = function() {
        context.globalCompositeOperation = 'source-in';
        context.fillStyle = 'rgba(128,128,128,0.85)';
        context.fillRect(0, 0, canvas.width, canvas.height);
        context.globalCompositeOperation = 'lighter';
        context.fillStyle = 'rgba(128,128,128,0.5)';
        for (var i = 0, il = amount; i < il; i++) {
            var a = particles[i];
            for (var j = i + 1; j < amount; j++) {
                var b = particles[j];
                var vec = a.position.sub(b.position);
                var length = vec.length();
                vec.idiv(Math.pow(length, 3) / factor);
                if (length > min_proximity) {
                    b.acceleration.iadd(vec);
                    a.acceleration.isub(vec);
                }
            }
            a.step();
            a.draw(context);
        }
    }
    var start = this.start = function() {
        toggle.text('on');
        interval = setInterval(step, milliseconds);
    }
    var stop = this.stop = function() {
        toggle.text('off');
        context.clearRect(0, 0, canvas.width, canvas.height);
        clearInterval(interval);
        interval = null;
    }
}
$(function() {
    var system = new System(15, 40);
    if (system.ready && $.cookie('particles') != 'off') {
        system.start();
    }
})


// ****************************** END


var comments;
function strip(text) {
    return text.replace(/^\s+/g, '').replace(/\s+$/g, '');
}
$.extend($.easing, {easeOutBounce: function(x, t, b, c, d) {
        if ((t /= d) < (1 / 2.75)) {
            return c * (7.5625 * t * t) + b;
        } else if (t < (2 / 2.75)) {
            return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b;
        } else if (t < (2.5 / 2.75)) {
            return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b;
        } else {
            return c * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b;
        }
    }});
var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
var datestring = function(seconds) {
    var d = new Date(seconds * 1000);
    var hours = d.getHours();
    if (hours < 10) {
        hours = '0' + hours;
    }
    var minutes = d.getMinutes();
    if (minutes < 10) {
        minutes = '0' + minutes;
    }
    return months[d.getMonth()] + '. ' + d.getDate() + ', ' + d.getFullYear() + ' ' + hours + ':' + minutes;
}
var pulse = function(element) {
    element.animate({'background-color': 'red'}, 500, 'easeOutBounce', function() {
        element.animate({'background-color': 'white'}, 500, 'swing');
    });
}
var Comments = function() {
    var current_id = null;
    var current_url = null;
    var sidebar = $('#sidebar')
    var body;
    var content;
    var filled = false;
    this.toggle = function(id, url) {
        sidebar.stop().clearQueue();
        if (current_id == id) {
            hide();
        } 
        else {
            show(id, url);
        }
    }
    var btn = $('#comments_btn').click(function() {
        show(this.name, document.location.href);
    });
    $(window).resize(function() {
        var height = $(window).height() - 10;
        sidebar.css('height', height);
        if (body) {
            body.css('height', height - 40);
        }
        if (content) {
            content.css('height', height - 40);
        }
    });
    var show = function(id, url) {
        current_id = id;
        current_url = url;
        var height = $(window).height() - 10;
        sidebar.empty().css('height', height);
        var header = $('<div class="header"></div>').appendTo(sidebar);
        $('<div id="hide" class="button">close</div>').appendTo(header).click(hide);
        body = $('<div class="content"></div>').appendTo(sidebar).css('height', height - 40);
        content = $('<div id="disqus_thread" class="comments"><div>').appendTo(body).css('height', height - 40);
        var disqus_shortname = 'codeflow';
        disqus_identifier = id;
        disqus_url = url;
        var dsq = document.createElement('script');
        dsq.type = 'text/javascript';
        dsq.async = true;
        dsq.src = 'http://codeflow.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        sidebar.animate({right: 0}, 1000, 'easeOutBounce');
        btn.animate({right: -150}, 300);
    }
    var hide = function(path) {
        sidebar.unbind('mouseleave');
        current_id = null;
        sidebar.animate({right: -600}, 500);
        btn.animate({right: 0}, 1000, 'easeOutBounce');
    }
};
$(function() {
    comments = new Comments();
});
if (!this.JSON) {
    this.JSON = {};
}
(function() {
    function f(n) {
        return n < 10 ? '0' + n : n;
    }
    if (typeof Date.prototype.toJSON !== 'function') {
        Date.prototype.toJSON = function(key) {
            return isFinite(this.valueOf()) ? this.getUTCFullYear() + '-' + 
            f(this.getUTCMonth() + 1) + '-' + 
            f(this.getUTCDate()) + 'T' + 
            f(this.getUTCHours()) + ':' + 
            f(this.getUTCMinutes()) + ':' + 
            f(this.getUTCSeconds()) + 'Z' : null;
        };
        String.prototype.toJSON = Number.prototype.toJSON = Boolean.prototype.toJSON = function(key) {
            return this.valueOf();
        };
    }
    var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, gap, indent, meta = {'\b': '\\b','\t': '\\t','\n': '\\n','\f': '\\f','\r': '\\r','"': '\\"','\\': '\\\\'}, rep;
    function quote(string) {
        escapable.lastIndex = 0;
        return escapable.test(string) ? '"' + string.replace(escapable, function(a) {
            var c = meta[a];
            return typeof c === 'string' ? c : '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
        }) + '"' : '"' + string + '"';
    }
    function str(key, holder) {
        var i, k, v, length, mind = gap, partial, value = holder[key];
        if (value && typeof value === 'object' && typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }
        if (typeof rep === 'function') {
            value = rep.call(holder, key, value);
        }
        switch (typeof value) {
            case 'string':
                return quote(value);
            case 'number':
                return isFinite(value) ? String(value) : 'null';
            case 'boolean':
            case 'null':
                return String(value);
            case 'object':
                if (!value) {
                    return 'null';
                }
                gap += indent;
                partial = [];
                if (Object.prototype.toString.apply(value) === '[object Array]') {
                    length = value.length;
                    for (i = 0; i < length; i += 1) {
                        partial[i] = str(i, value) || 'null';
                    }
                    v = partial.length === 0 ? '[]' : gap ? '[\n' + gap + 
                    partial.join(',\n' + gap) + '\n' + 
                    mind + ']' : '[' + partial.join(',') + ']';
                    gap = mind;
                    return v;
                }
                if (rep && typeof rep === 'object') {
                    length = rep.length;
                    for (i = 0; i < length; i += 1) {
                        k = rep[i];
                        if (typeof k === 'string') {
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                } else {
                    for (k in value) {
                        if (Object.hasOwnProperty.call(value, k)) {
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                }
                v = partial.length === 0 ? '{}' : gap ? '{\n' + gap + partial.join(',\n' + gap) + '\n' + 
                mind + '}' : '{' + partial.join(',') + '}';
                gap = mind;
                return v;
        }
    }
    if (typeof JSON.stringify !== 'function') {
        JSON.stringify = function(value, replacer, space) {
            var i;
            gap = '';
            indent = '';
            if (typeof space === 'number') {
                for (i = 0; i < space; i += 1) {
                    indent += ' ';
                }
            } else if (typeof space === 'string') {
                indent = space;
            }
            rep = replacer;
            if (replacer && typeof replacer !== 'function' && (typeof replacer !== 'object' || typeof replacer.length !== 'number')) {
                throw new Error('JSON.stringify');
            }
            return str('', {'': value});
        };
    }
    if (typeof JSON.parse !== 'function') {
        JSON.parse = function(text, reviver) {
            var j;
            function walk(holder, key) {
                var k, v, value = holder[key];
                if (value && typeof value === 'object') {
                    for (k in value) {
                        if (Object.hasOwnProperty.call(value, k)) {
                            v = walk(value, k);
                            if (v !== undefined) {
                                value[k] = v;
                            } else {
                                delete value[k];
                            }
                        }
                    }
                }
                return reviver.call(holder, key, value);
            }
            cx.lastIndex = 0;
            if (cx.test(text)) {
                text = text.replace(cx, function(a) {
                    return '\\u' + 
                    ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
                });
            }
            if (/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@').replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']').replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {
                j = eval('(' + text + ')');
                return typeof reviver === 'function' ? walk({'': j}, '') : j;
            }
            throw new SyntaxError('JSON.parse');
        };
    }
}());
jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') {
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString();
        }
        var path = options.path ? '; path=' + (options.path) : '';
        var domain = options.domain ? '; domain=' + (options.domain) : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else {
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};
(function(jQuery) {
    jQuery.each(['backgroundColor', 'borderBottomColor', 'borderLeftColor', 'borderRightColor', 'borderTopColor', 'color', 'outlineColor'], function(i, attr) {
        jQuery.fx.step[attr] = function(fx) {
            if (fx.state == 0) {
                fx.start = getColor(fx.elem, attr);
                fx.end = getRGB(fx.end);
            }
            fx.elem.style[attr] = "rgb(" + [Math.max(Math.min(parseInt((fx.pos * (fx.end[0] - fx.start[0])) + fx.start[0]), 255), 0), Math.max(Math.min(parseInt((fx.pos * (fx.end[1] - fx.start[1])) + fx.start[1]), 255), 0), Math.max(Math.min(parseInt((fx.pos * (fx.end[2] - fx.start[2])) + fx.start[2]), 255), 0)].join(",") + ")";
        }
    });
    function getRGB(color) {
        var result;
        if (color && color.constructor == Array && color.length == 3)
            return color;
        if (result = /rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(color))
            return [parseInt(result[1]), parseInt(result[2]), parseInt(result[3])];
        if (result = /rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(color))
            return [parseFloat(result[1]) * 2.55, parseFloat(result[2]) * 2.55, parseFloat(result[3]) * 2.55];
        if (result = /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(color))
            return [parseInt(result[1], 16), parseInt(result[2], 16), parseInt(result[3], 16)];
        if (result = /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(color))
            return [parseInt(result[1] + result[1], 16), parseInt(result[2] + result[2], 16), parseInt(result[3] + result[3], 16)];
        return colors[jQuery.trim(color).toLowerCase()];
    }
    function getColor(elem, attr) {
        var color;
        do {
            color = jQuery.curCSS(elem, attr);
            if (color != '' && color != 'transparent' || jQuery.nodeName(elem, "body"))
                break;
            attr = "backgroundColor";
        } while (elem = elem.parentNode);
        return getRGB(color);
    }
    ;
    var colors = {aqua: [0, 255, 255],azure: [240, 255, 255],beige: [245, 245, 220],black: [0, 0, 0],blue: [0, 0, 255],brown: [165, 42, 42],cyan: [0, 255, 255],darkblue: [0, 0, 139],darkcyan: [0, 139, 139],darkgrey: [169, 169, 169],darkgreen: [0, 100, 0],darkkhaki: [189, 183, 107],darkmagenta: [139, 0, 139],darkolivegreen: [85, 107, 47],darkorange: [255, 140, 0],darkorchid: [153, 50, 204],darkred: [139, 0, 0],darksalmon: [233, 150, 122],darkviolet: [148, 0, 211],fuchsia: [255, 0, 255],gold: [255, 215, 0],green: [0, 128, 0],indigo: [75, 0, 130],khaki: [240, 230, 140],lightblue: [173, 216, 230],lightcyan: [224, 255, 255],lightgreen: [144, 238, 144],lightgrey: [211, 211, 211],lightpink: [255, 182, 193],lightyellow: [255, 255, 224],lime: [0, 255, 0],magenta: [255, 0, 255],maroon: [128, 0, 0],navy: [0, 0, 128],olive: [128, 128, 0],orange: [255, 165, 0],pink: [255, 192, 203],purple: [128, 0, 128],violet: [128, 0, 128],red: [255, 0, 0],silver: [192, 192, 192],white: [255, 255, 255],yellow: [255, 255, 0]};
})(jQuery);
