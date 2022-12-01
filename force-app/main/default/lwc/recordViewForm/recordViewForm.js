import { LightningElement ,api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';
import Email from '@salesforce/schema/Contact.Email';
import Phone from '@salesforce/schema/Account.Phone';


export default class RecordViewForm extends LightningElement {


    nameField = NAME_FIELD;

    // Flexipage provides recordId and objectApiName
    @api recordId ="0035i000004T1R3AAK";
    @api objectApiName = NAME_FIELD;

    
}