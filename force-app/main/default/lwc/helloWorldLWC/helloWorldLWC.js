import { LightningElement, track, wire } from 'lwc';


import getaccount from '@salesforce/apex/DefaultApexLwc.getAccount';
import getcontact from '@salesforce/apex/DefaultApexLwc.getContact';


export default class AccountRelatedObj extends LightningElement {

    @track acc;
    @track con;
    flagBool = 0;
    message;
    msg;



    @wire(getaccount)
    getPcList({ data, error }) {
        if (data) {
            this.acc = data;
        } else if (error) {
            console.log("Error is Here" + this.error);
        }
    }

    /* getaccount()
        .then(result => {
            this.acc = result;
            console.log("without json--->" + this.acc);
            console.log("with json" + JSON.stringify(this.acc));
            console.log("result", this.acc);
        })
    */


    changeFlagValue() {

        this.flagBool = 1
    }



    @wire(getcontact, { accId: '$message' })
    getPeList({ data, error }) {
        if (data) {
            this.con = data;
        } else if (error) {
            console.log("Error is Here" + this.error);
        }
    }



    contactFetch(event) {
        this.changeFlagValue()
        this.message = event.target.value;
        console.log('Contact Id-->' + this.message);
        // this.getPeList();



    }
}