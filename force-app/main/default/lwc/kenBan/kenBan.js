import { LightningElement, wire } from 'lwc';
import {getListUi} from 'lightning/uiListApi';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName'
import { updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Opportunity.Id';

export default class KenBan extends LightningElement {

    records = []
    pickVals = []
    recordId = null

    @wire(getListUi, {
        objectApiName: OPPORTUNITY_OBJECT,
        listViewApiName: 'AllOpportunities'
    })wiredListView({error, data}){
        if(data){
           // console.log('getListUi',data);
            console.log('data-->'+JSON.stringify(data));
         this.records = data.records.records.map(item=>{
                let field = item.fields
                return {'Id':field.Id.value, 'Name':field.Name.value, 'CloseDate':field.CloseDate.value, 'StageName':field.StageName.value, 'Amount':field.Amount.value }
              })
              console.log('records--->'+JSON.stringify(this.records));
        }
        if(error){
            console.error(error);
        }
    }

    /** fetch meta data of opportunity */

    @wire(getObjectInfo, {objectApiName:OPPORTUNITY_OBJECT})
    objectInfo

    /**fetching stage pickList */

    @wire(getPicklistValues, {
        recordTypeId:'$objectInfo.data.defaultRecordTypeId', fieldApiName:STAGE_FIELD 
    })stagePickListValue({data,error}){
        if(data){
            console.log('stagePickList-->'+JSON.stringify(data))
            this.pickVals = data.values.map(item => item.value)
        }
        if(error){
            console.error(error)
        }
    }

    get setWidth(){
        let len = this.pickVals.length
        return `width: calc(100vw/${len})`
    }


    handleListItemDrag(event){
        this.recordId = event.detail
        console.log('on parent drag-->'+this.recordId)
    }


    handleItemDrop(event){
        
        let stage = event.detail
      
        this.updateDate(stage);
    }

    updateDate(stage){
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[STAGE_FIELD.fieldApiName] = stage;
        const recordInput = {fields};
        updateRecord(recordInput)
        .then(()=>{
            console.log('record has been updated');
           // console.log('result'+result);
        }).catch(error=>{
            console.error('error-->'+error);
        })

    }




}