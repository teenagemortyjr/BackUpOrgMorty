import { LightningElement } from 'lwc';

export default class ExpLwc extends LightningElement {
    headText = 'red'


    get cusStyle(){
        if(this.headText === 'red'){
            return `color:red`
        }
    }

}