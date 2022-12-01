import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity'
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName'
import ID_FIELD from '@salesforce/schema/Opportunity.Id'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UseMeForTest extends LightningElement {

    records
    pickVals
    recordId
    /*** fetching Opportunity lists ***/
    @wire(getListUi, {
        objectApiName: OPPORTUNITY_OBJECT,
        listViewApiName:'AllOpportunities'
    })wiredListView({error, data}){
        if(data){
            console.log("OPPORTUNITY_OBJECT-->"+OPPORTUNITY_OBJECT)
            console.log("getListUi"+ data)
            this.records = data.records.records.map(item => {
                let field = item.fields
                let account = field.Account.value.fields
                return { 'Id': field.Id.value, 'Name': field.Name.value, 'AccountId': account.Id.value, 'AccountName': account.Name.value, 'CloseDate': field.CloseDate.value, 'StageName': field.StageName.value, 'Amount': field.Amount.value }

            })

            console.log("return data-->"+this.records)
        }
        if(error){
            console.error(error)
        }
    }

/** Fetch metadata abaout the opportunity object**/
@wire(getObjectInfo, {objectApiName:OPPORTUNITY_OBJECT})
objectInfo
/*** fetching Stage Picklist ***/

    @wire(getPicklistValues, {
        recordTypeId:'$objectInfo.data.defaultRecordTypeId',
        fieldApiName:STAGE_FIELD
    })stagePicklistValues({ data, error}){
        if(data){
            console.log("objectInfo-->"+this.objectInfo)
            console.log("Object Id-->"+this.objectInfo.data.defaultRecordTypeId)
            console.log("Stage Picklist", data)
            this.pickVals = data.values.map(item => item.value)
        }
        if(error){
            console.error(error)
        }
    }


}