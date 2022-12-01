import { LightningElement } from 'lwc';

export default class LookUpExample extends LightningElement {


    selectedAccount;
    objectName = 'Countrie__c';

    handleAccountSelection(event){
        this.selectedAccount = event.target.value;
        alert("The selected Accout id is"+this.selectedAccount);
    }
}