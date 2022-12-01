import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'

export default class KanBanDragDrop extends NavigationMixin(LightningElement) {

    @api stage
    @api record

    get isSameStage(){
        return this.stage === this.record.StageName
    }

    navigateOppHandler(event){
        let Id = event.target.dataset.id
        console.log('id-->'+Id)
        event.preventDefault();
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: Id,
                objectApiName: 'opportunity',
                actionName: 'view',
            },
        });
    }


    itemDragStart(){
        console.log('strart drag child')
        const event = new CustomEvent('itemdrag', {
            detail: this.record.Id
        })
        this.dispatchEvent(event)
    }


  
    
}