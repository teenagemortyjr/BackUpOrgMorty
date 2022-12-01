({
    validateAccountRecords: function(component, event) {
        //Validate all account records
        var isValid = true;
        var contactList = component.get("v.conList");
        for (var i = 0; i < contactList.length; i++) {
            if (contactList[i].LastName == '') {
                isValid = false;
                alert('Contact LastName cannot be blank on '+(i + 1)+' row number');
            }
        }
        return isValid;
    },
})