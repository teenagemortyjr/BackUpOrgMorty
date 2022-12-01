import { LightningElement,wire } from 'lwc';
import getAccount from '@salesforce/apex/defaultApex.getAccountName'

export default class SundayTestLWC extends LightningElement {
    

    filterType = ''
    accListIsEmpty = true    
    @wire( getAccount,{s:'$filterType'})
        filteredAccounts



 


     get getOptions(){

        return [
            {label:"Customer - Channel",value:"Customer - Channel"},
            {label:"Customer - Direct", value:"Customer - Direct"}
        ]

     }

     typeHandler(event){
        console.log("typeHandler")
        
        console.log("before "+this.filterType)
        this.accListIsEmpty = false
        this.filterType = event.target.value
        console.log("after "+this.filterType)
     }

    


 


}