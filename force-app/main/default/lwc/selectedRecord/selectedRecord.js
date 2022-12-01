import { LightningElement, api } from 'lwc';

export default class SelectedRecord extends LightningElement {

    @api iconUrl;
    @api objectLabel;
    @api record;
    @api index;
    @api showLabel = false;

    handleChange1 = (event) =>{
        // Creates the event
        const selectedEvent = new CustomEvent('valueselected', {
            detail: event.detail.value,
            detail: {
                data : {
                    record     : undefined,
                    recordId   : undefined
                }
            }
        });
        console.log("record name is"+JSON.stringify(this.record))
        console.log("record id in child is+"+JSON.stringify(this.recordId))
        
        this.dispatchEvent(selectedEvent);
    }


    handleRemove = (event) => {
        event.preventDefault();
        const closeEvent = new CustomEvent('close', {
            bubbles    : true,
            composed   : true,
            cancelable : true,
            detail: {
                data : {
                    record     : undefined,
                    recordId   : undefined
                }
            }
        });
        console.log("record name is"+JSON.stringify(this.record))
        console.log("record id in child is+"+JSON.stringify(this.recordId))
        this.dispatchEvent(closeEvent);
    }
}