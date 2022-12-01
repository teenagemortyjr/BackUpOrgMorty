import { LightningElement,track} from 'lwc'
import getOpportunityLineItem from '@salesforce/apex/defaultApex.getOpportunityLineItem'




export default class ShowProductRelatedToAccount extends LightningElement {

    @track selectedAccount;
   @track productData 


   value = '';

    get options() {
        return [
            { label: 'Sales', value: 'option1' },
            { label: 'Force', value: 'option2' },
        ];
    }

   columns = [
    { label: 'Product Id', fieldName: 'Id' },
    { label: 'Product Name', fieldName: 'Name' },
    { label: 'Quantity', fieldName: 'Quantity' },
     { label: 'ProductCode', fieldName: 'ProductCode' },
    { label: 'Total Price', fieldName: 'TotalPrice' ,type:'currency' }
];


    handleAccountSelection(event){
        this.selectedAccount = event.target.value;
       // alert("The selected Accout id is"+this.selectedAccount);


        getOpportunityLineItem({accountId:this.selectedAccount}).then(result => {
            this.productData = result;
            console.log('data--->'+  JSON.stringify(this.productData))
        })
        .catch(error => {
            this.error = error;
        });
    }
  

}