import { LightningElement, api } from 'lwc';

export default class TaskPriorityList extends LightningElement {

    @api records
    @api tabname

    
    connectedCallback(){
        console.log('child 1');
    }

   
    onItemDragHandler(evnt){
        console.log('on chid-parent drag')
        const event = new CustomEvent('listitemdrag', {
            detail: evnt.detail
        })
        this.dispatchEvent(event)
    }


    handleDrop(){
        console.log('on drop ...... tab name-->'+this.tabname)
        const event = new CustomEvent('itemdrop', {
            detail: this.tabname
        })
        this.dispatchEvent(event)

    }

    handleDragOver(event){
        console.log('card drag overing--->')
        event.preventDefault();

    }
}