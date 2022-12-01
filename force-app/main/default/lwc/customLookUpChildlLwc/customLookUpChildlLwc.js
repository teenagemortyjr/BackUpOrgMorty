import {LightningElement} from 'lwc';

export default class customLookUpChildLwc extends LightningElement {
    handleAccountSelection(event){
        console.log("the selected record id is"+event.detail);
    }
}