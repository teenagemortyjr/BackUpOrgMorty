import { LightningElement } from 'lwc';

export default class P2cParentComponent extends LightningElement {


    isFlagTrue = false;

    setFlagFalse(event) {

        this.isFlagTrue = true;

        this.template.querySelector('div').classList.add('slds-hidden');
    }
}