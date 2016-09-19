var hb = require('handlebars');
var _  = require('lodash');

    function checkCondition(v1, operator, v2) {
        switch (operator) {
            case '==':
                return (v1 == v2);
            case '===':
                return (v1 === v2);
            case '!==':
                return (v1 !== v2);
            case '<':
                return (v1 < v2);
            case '<=':
                return (v1 <= v2);
            case '>':
                return (v1 > v2);
            case '>=':
                return (v1 >= v2);
            case '&&':
                return (v1 && v2);
            case '||':
                return (v1 || v2);
            default:
                return false;
        }
    }


    hb.registerHelper('csv', function(context) {
        var ret = "";
        for (var i = 0, j = context.length; i < j; i++) {
            ret = ret + "'" + (context[i]) + "'";
            if (i < (j - 1)) ret = ret + ', ';
        }
        return ret;
    });

    hb.registerHelper('toLowerCase', function(value) {
        if (value) {
            return new hb.SafeString(value.toLowerCase());
        } else {
            return '';
        }
    });

    hb.registerHelper('ucFirst', function(value) {
        if (value) {
            return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
        } else {
            return '';
        }
    });

    hb.registerHelper('cameLize', function(value) {
        if (value) {
            var array_val = value.split('_');
            var newval = [];
            _.forEach(array_val, function(val){
                newval.push(val.charAt(0).toUpperCase() + val.slice(1).toLowerCase());
            });     

            return newval.join("");
        } else {
            return '';
        }
    });

    hb.registerHelper('ife', function(value, valueb) {
        if (value) {
            return new hb.SafeString(valueb);
        } else {
            return '';
        }
    });

    hb.registerHelper('ifc', function(v1, v2, options) {
        if (v1 === v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    });

    hb.registerHelper('contains', function(v1, v2, options) {
        if (_.contains(v1, v2)) {
            return options.fn(this);
        }
        return options.inverse(this);
    });

    hb.registerHelper('ifcond', function(v1, operator, v2, options) {
        return checkCondition(v1, operator, v2) ? options.fn(this) : options.inverse(this);
    });


    module.exports = hb