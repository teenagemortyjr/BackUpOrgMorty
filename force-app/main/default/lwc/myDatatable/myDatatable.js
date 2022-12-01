import { LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/defaultApex.getAccountList';
import UserPreferencesHideS1BrowserUI from '@salesforce/schema/User.UserPreferencesHideS1BrowserUI';

const COLS = [
    { label: 'Account Name', type: 'customText', fieldName: 'Name',
     typeAttributes: {
        accountName: { fieldName: 'Name' }
    },
    },
    { label: 'Industry',  type: 'customNumber', typeAttributes: {
        Industry: { fieldName: 'Industry' }
    },
    
    },
    { label: 'Employees', type: 'customNumber', fieldName: 'NumberOfEmployees',
     typeAttributes: {
        status: {fieldName: 'status'}
    }
    
}];



export default class MyDatatable extends LightningElement {
    columns = COLS;
    @track accounts = [];

    @wire(getAccountList)
    wiredAccounts({error, data}) {
        if (error) {
            // Handle error
        } else if (data) {
            // Process record data
            this.accounts = data
                
            
        }
    }

    
    handleClick(event){
        console.log("You click me")
    }
}