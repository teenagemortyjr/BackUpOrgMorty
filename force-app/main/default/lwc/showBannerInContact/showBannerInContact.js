import { LightningElement ,api,track,wire} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name'
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
import { refreshApex } from '@salesforce/apex'
import checkForBanner from '@salesforce/apex/defaultApex.checkForBanner'

const FIELDS = [
    'account.Name',
    'account.showBanner__c'
    
];

export default class ShowBannerInContact extends LightningElement {

    isShowBanner = false
    accountName 


    

    @api recordId;
    @api objectApiName;
    @track objectInfo;

    opportunityRecordId;

    records = []
    result = []


    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account({ error, data }){
        if(data){
        console.log('Account details'+JSON.stringify(data))
        console.log('Account Name-->'+data.fields.Name.value)
        this.accountName = data.fields.Name.value
        this.isShowBanner = data.fields.showBanner__c.value
        console.log('showBanner-->'+data.fields.showBanner__c.value)
        }
    }

 

     @wire(getRelatedListRecords, {
         parentRecordId: '$recordId',
         relatedListId: 'Opportunities',
       fields: ['Opportunity.Name','Opportunity.Id'],
         sortBy: ['Opportunity.Name']
     })listInfo({ error, data }) {
         if(data){
          
           //console.log(JSON.stringify(data))
             const fieldsValue = (data.records)

                console.log('inside the data')
                 //console.log('item  --->'+JSON.stringify(data.records))
            try{
                for(let i=0;i<fieldsValue.length;i++){
                 console.log('valeu----->'+(fieldsValue[i].fields.Id.value))
                 this.opportunityRecordId = fieldsValue[i].fields.Id.value
                }
            }catch(err){
                console.log(JSON.stringify(err))
            }
              //  this. checkQuantity()
        }

         if(error){
             console.error('error 49 --> ',JSON.stringify(error))
         }
     }

     checkQuantity(){

        checkForBanner({accountId:this.recordId,opportunityId:this.opportunityRecordId })
        .then((result)=> {
            console.log('working fine-->'+this.isShowBanner)
            this.isShowBanner = result
        })
     }

 
    @wire(getRelatedListRecords, {
    
        parentRecordId: '0065i0000093INwAAM',
        relatedListId: 'OpportunityLineItems',
        fields: ['OpportunityLineItem.Name','OpportunityLineItem.Quantity'],
        sortBy: ['OpportunityLineItem.Name']
    })listInfo2({ error, data }) {
        if(data){
            console.log(JSON.stringify(data))
            const fieldsValue = (data.records)

                console.log('inside the data of opportunity line item')
                console.log('item  --->'+JSON.stringify(data.records))

        
        }

        if(error){
            console.error('error 102s --> ',JSON.stringify(error));
        }
    }  
  
    
    /*  @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD] })
    AccountRecord({data,error}){
        if(data){
            console.log(JSON.stringify(data))
            const {fields} = data

            Object.keys(fields).forEach(item=>{

                let value = fields[item] && fields[item].displayValue ? fields[item].displayValue : fields[item].value
                console.log('value-->'+value)
                this.result = { ...this.result, [item]:value}
                console.log('result-->'+this.result)
            })
        }

        if(error){
            console.error(error)
        }
    }
 */
    

  

   


    }