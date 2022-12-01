import { LightningElement, wire, api } from 'lwc';


import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';

export default class ImportDataWithoutApexCall extends LightningElement {

    @api recordId;

    @wire(getRecord, { recordId: '0015i000006S4r1AAC', fields: [NAME_FIELD, INDUSTRY_FIELD, RATING_FIELD, WEBSITE_FIELD] })
    record;

    get myName() {
        return getFieldValue(this.record.data, NAME_FIELD);
    }

    get myIndustry() {
        return getFieldValue(this.record.data, INDUSTRY_FIELD);
    }

    get myRating() {
        return getFieldValue(this.record.data, RATING_FIELD);
    }

    get myWebsite() {
        return getFieldValue(this.record.data, WEBSITE_FIELD);
    }




}