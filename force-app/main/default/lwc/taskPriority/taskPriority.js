import { LightningElement,wire,track } from 'lwc';
import TASK_OBJECT from '@salesforce/schema/Task__c';
import { getListUi } from 'lightning/uiListApi';
import ID_FIELD from '@salesforce/schema/Task__c.Id';
import NAME_FIELD from '@salesforce/schema/Task__c.Name';
import { updateRecord } from 'lightning/uiRecordApi';

export default class TaskPriority extends LightningElement {

    @track records = []
    recordId = null
    taskPriority = null

    tabBar = ['Task List' ,'Low', 'Medium','High']


    @wire(getListUi ,{
        objectApiName: TASK_OBJECT,
        listViewApiName: 'All'

    })wiredListView({error, data}){ 
        if(data){
           // console.log('getListUi',data);
            console.log(JSON.stringify(data));

             this.records = data.records.records.map(item=>{
                let field = item.fields;
                return {'Id': field.Id.value, 'Task': field.Name.value, 'Stage':'' , 'priorityColor':'' }
            }) 

            console.log('after insertion -->'+JSON.stringify(this.records));
        }
        if(error){
            console.error('error---.'+JSON.stringify(error));
        }
    }

    get setWidth(){
        let len = this.tabBar.length
        return `width: calc(100vw/${len})`
    }



    handleListItemDrag(event){
       
        console.log('on parent drag-->'+  event.detail)
        this.recordId = event.detail;
    }


    handleItemDrop(event){
        
        console.log('on parent dragooooooo-->'+  event.detail);
        this.taskPriority = event.detail;
        let taskColor = 'blue'

        if(this.taskPriority == 'High'){
            taskColor = 'red'
        }else if(this.taskPriority == 'Medium'){
            taskColor = 'green'
        }

        this.records = this.records.map(item=>{
    
         return item.Id === this.recordId ? {...item, Stage:this.taskPriority, priorityColor:taskColor}:{...item}
        })
        console.log('after change update-->'+JSON.stringify(this.records))
        
    }

    updateDate(){
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[STAGE_FIELD.fieldApiName] =  this.taskPriority ;
        const recordInput = {fields};
        updateRecord(recordInput)
        .then(()=>{
            console.log('record has been updated');
            this.showToast();
            return refreshApex(this.wiredListView)
            
           // console.log('result'+result);
        }).catch(error=>{
            console.error('error-->'+error);
        })

    }

    showToast(){
        this.dispatchEvent(
            new ShowToastEvent({
                title:'Success',
                message:'Stage updated Successfully',
                variant:'success'
            })
        )
    }





}