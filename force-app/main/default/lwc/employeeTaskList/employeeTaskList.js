import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

export default class employeeTaskList extends LightningElement {
    // Expose a field to make it available in the template
    nameField = NAME_FIELD;
    contactNameList = []

    fistName
    lastName
    email

    handleSuccess(event){
        console.log('Contact has been created');
        if(!this.fistName){
            this.contactNameList.push(this.firstName);
        }
        console.log('list-->'+this.contactNameList);
        console.log(this.firstName+'--->'+this.lastName+'----->'+this.email);
     
      //  this.notification();
        
    }
    notification() {
        const evt = new ShowToastEvent({
            title: "Success",
            message: "Contact has been created",
            variant: "success"
        });
        this.dispatchEvent(evt);
    }

    firstNameHandler(event){
        this.firstName = event.target.value;
    }

    lastNameHandler(event){
        this.lastName = event.target.value;
    }

    emailHandler(event){
        this.email = event.target.value
    }

   
}