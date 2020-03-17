jQuery(function(e){
	"use strict";
	
	jQuery(".phonenumber-inputmask").inputmask("9999999999"),
	
	jQuery(".email-inputmask").inputmask({
        mask: "*{1,20}[.*{1,20}][.*{1,20}][.*{1,20}]@*{1,20}[*{2,6}][*{1,2}].*{1,}[.*{2,6}][.*{1,2}]",
        greedy: !1,
        onBeforePaste: function(n, a) {
            return (e = e.toLowerCase()).replace("mailto:", "")
        },
        definitions: {
            "*": {
                validator: "[0-9A-Za-z!#$%&'*+/=?^_`{|}~/-]",
                cardinality: 1,
                casing: "lower"
            }
        }
    })
	
	
})