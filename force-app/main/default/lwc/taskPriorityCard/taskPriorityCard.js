import { LightningElement,api } from 'lwc';

export default class TaskPriorityCard extends LightningElement {

    @api record
    @api tabname

     firstRender = true

   get checkTabNameisTask(){
    console.log('record-...->'+JSON.stringify(this.record))
    console.log('tabName-->'+this.tabname);
    console.log(this.tabname === 'Task List')
    this.firstRender = true
        return  this.record.Stage == '' && this.tabname == 'Task List' && this.firstRender
    }



    get checkTaskNameIsMedium(){
        this.firstRender = false
        console.log('data->'+JSON.stringify(this.record))
        console.log('tabName check task Name is Medium-->'+this.record.Stage);
        return  this.record.Stage == 'Medium' && this.tabname == 'Medium'

    }

    
    get checkTaskNameIsLow(){
        this.firstRender = false
        console.log('data->'+JSON.stringify(this.record))
        console.log('tabName check task Name is Medium-->'+this.record.Stage);
        return  this.record.Stage == 'Low'&& this.tabname == 'Low'

    }

    
    get checkTaskNameIsHigh(){
        this.firstRender = false
        console.log('data->'+JSON.stringify(this.record))
        console.log('tabName check task Name is Medium-->'+this.record.Stage);
        return  this.record.Stage == 'High' && this.tabname == 'High'

    }


    itemDragStart(){
        this.firstRender = false
        console.log('strart drag child')
        const event = new CustomEvent('itemdrag', {
            detail: this.record.Id
        })
        this.dispatchEvent(event)
    }

    connectedCallback(){
        console.log('child 2');
    }

    get setColor(){
            return `background:${this.record.priorityColor}; color:white`
    }
}