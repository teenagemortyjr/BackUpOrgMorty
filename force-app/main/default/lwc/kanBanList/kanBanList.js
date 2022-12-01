import { LightningElement,api } from 'lwc';

export default class KanBanList extends LightningElement {

    @api records
    @api stage


    onItemDragHandler(evnt){
        console.log('on chid-parent drag')
        const event = new CustomEvent('listitemdrag', {
            detail: evnt.detail
        })
        this.dispatchEvent(event)
    }


    handleDrop(){
        console.log('on drop')
        const event = new CustomEvent('itemdrop', {
            detail: this.stage
        })
        this.dispatchEvent(event)

    }

    handleDragOver(event){
        console.log('card drag overing--->')
        event.preventDefault();

    }


}