import { LightningElement,
    track,
    wire,
    api} from 'lwc';

export default class ComboboxTask extends LightningElement {

    @track l_All_Types;
    @track TypeOptions;
    value 

    get TypeOptions() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }
  
 
    handleTypeChange(event){
        let Picklist_Value = event.target.value; 
        console.log(Picklist_Value)
    }



}