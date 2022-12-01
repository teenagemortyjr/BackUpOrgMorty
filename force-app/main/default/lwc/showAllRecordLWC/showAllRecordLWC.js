import { LightningElement, track, api } from 'lwc';
import getObjectList from '@salesforce/apex/defaultApex.getAllObjectNameList' ;
import getObjField from '@salesforce/apex/defaultApex.returnApi' ;
import getLookUpList from '@salesforce/apex/defaultApex.getLookUpList' ;
import getRecord from '@salesforce/apex/defaultApex.getAllRecord' ;
import search from '@salesforce/apex/defaultApex.search';
import getRecentlyCreatedRecord from '@salesforce/apex/defaultApex.getRecentlyCreatedRecord';
const DELAY = 10;


export default class ShowAllRecordLWC extends LightningElement {



    @track customObjectNameList
    @track selectedObject
    @track selectedRecord2
    @track ObjectFieldList
    @track lstSelected = [];
    @track isModalOpen = false;
    @track isRecordAvailable = false;
    @track columns
    @track data
    @track lookUpList
    @track lookupSelected

    @api valueId;
    @api valueName;
    @api objName = ''
    @api iconName = 'standard:account';
    @api labelName;
    @api currentRecordId;
    @api placeholder = 'Search';
    @api fields = ['Name'];
    @api displayFields = 'Name, Rating, AccountNumber';
    @api showLabel = false;
    @api parentAPIName = 'ParentId';
    @api createRecord = false;
    @track error;
    @track objectRecordId


    @api recordTypeId;
    @api fieldsToCreate = [];
    @api index;
    

    

    searchTerm;
    delayTimeout;

    

    searchRecords;
    selectedRecord;
    objectLabel;
    isLoading = false;
    showButton = false;
    showModal = false;

    field;
    field1;
    field2;

    ICON_URL = '/apexpages/slds/latest/assets/icons/{0}-sprite/svg/symbols.svg#{1}';
    ICON_URL_NEW = '/apexpages/slds/latest/assets/icons/utility-sprite/svg/symbols.svg#add';
    ICON_URL_CLOSE = '/apexpages/slds/latest/assets/icons/utility-sprite/svg/symbols.svg#close';


    handleInputChange(event){
        console.log(" name ---->  "+event.target.value)

    }

    onLookupSelected(event) {
        this.lookupSelected = event.detail.value
    }

    handleChange(event) {

        this.lstSelected = event.detail.value;
        console.log("select value is" + this.lstSelected)
        let tempNameList = []
        for (var key in this.lstSelected) {
            console.log(`key--${this.lstSelected[key]}   fieldName-->${this.lstSelected[key]}`);
            tempNameList.push({ label: this.lstSelected[key], fieldName: this.lstSelected[key] });
        }


        this.columns = tempNameList
        console.log("column-->" + this.columns)
        this.isRecordAvailable = true
        console.log("--->" + this.isRecordAvailable)

        console.log("selected object+" + this.selectedObject)
        console.log("Field list-->" + this.lstSelected)

        getRecord({ objectType: this.selectedObject, fieldList: this.lstSelected }).then(
            result => {
                console.log("look up field List-->" + JSON.stringify(result))
                let newRecordList = []

                console.log("before calling loop")
                for( let i in result){

                    newRecordList.push(Object.values(result[i]));
                    
                }
                console.log("all record --->"+newRecordList)
               let  tempNameList1 = []
                for (var key in newRecordList ) {
                    console.log(`key--${newRecordList[key]}   fieldName--->${newRecordList[key]}`);
                    tempNameList1.push({ label: newRecordList[key], fieldName: newRecordList[key] });
                }


                console.log("array value is-->"+tempNameList1)
                this.selectedRecord2 = tempNameList1

        }

        ).catch(error => {
            console.log("Error is here" + JSON.stringify(error))

        })


    }




    onSelectObject(event) {

        this.selectedObject = event.target.value
        this.objName = this.selectedObject
        console.log(this.selectedObject + "object os jere")



        // let icons = this.iconName.split(':');
        // this.ICON_URL = this.ICON_URL.replace('{0}', icons[0]);
        // this.ICON_URL = this.ICON_URL.replace('{1}', icons[1]);

        if (this.objName.includes('__c')) {
            let obj = this.objName.substring(0, this.objName.length - 3);
            this.objectLabel = obj.replaceAll('_', ' ');
        } else {
            this.objectLabel = this.objName;
        }

        if (this.valueId && this.valueName) {
            this.selectedRecord = {
                FIELD1: this.valueName,
                Id: this.valueId
            }
        }

        this.objectLabel = this.titleCase(this.objectLabel);
        let fieldList;
        if (!Array.isArray(this.displayFields)) {
            fieldList = this.displayFields.split(',');
        } else {
            fieldList = this.displayFields;
        }
        if (fieldList.length > 1) {
            this.field = fieldList[0].trim();
            this.field1 = fieldList[1].trim();
        }
        if (fieldList.length > 2) {
            this.field2 = fieldList[2].trim();
        }
        let combinedFields = [];
        fieldList.forEach(field => {
            if (!this.fields.includes(field.trim())) {
                combinedFields.push(field.trim());
            }
        });

        this.fields = combinedFields.concat(JSON.parse(JSON.stringify(this.fields)));


        if (this.valueId && this.valueName) {
            this.selectedRecord = {
                FIELD1: this.valueName,
                recordId: this.valueId

            }
        }

        console.log("here is record value-->"+this.valueName)
        console.log("here is record Id-->"+this.valueId)





        getObjField({ fieldName: this.selectedObject }).then(result => {

            let tempNameList = []
            for (var key in result) {
                console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push({ label: result[key], value: result[key] });
            }
            this.ObjectFieldList = tempNameList



        }).catch(errorv => {
            console.log("Error is here" + JSON.stringify(error))

        })


    }


    connectedCallback() {

        getObjectList().then(result => {
            console.log('result -->'+ JSON.stringify(result));

            let tempNameList = [];
            for (var key in result) {
                console.log('Key-check-'+key);
                console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push({ label: result[key], value: result[key] });
            }

            this.customObjectNameList = tempNameList ;
            console.log('customObjectNameList -->>'+this.customObjectNameList.length);


        }).catch(error => {
            console.log("Error is here" + JSON.stringify(error))
        })







    }




    handleSelect(event) {

        let recordId = event.currentTarget.dataset.recordId;
        let selectRecord = this.searchRecords.find((item) => {
            return item.Id === recordId;
        });
        this.selectedRecord = selectRecord;
        const selectedEvent = new CustomEvent('lookup', {
            bubbles: true,
            composed: true,
            cancelable: true,
            detail: {
                data: {
                    record: selectRecord,
                    recordId: recordId,
                    currentRecordId: this.currentRecordId,
                    parentAPIName: this.parentAPIName,
                    index: this.index
                }
            }
        });
        console.log('record in handler selelect-->'+recordId)
        this.objectRecordId = "'"+recordId+"'"
        console.log('record data +'+this.objectRecordId)
        this.dispatchEvent(selectedEvent);
    }


    onRecordSelect(event){
        console.log("event -->"+event)
        console.log("on record selecrt +"+event.target.value)
    }

    handleSubmit(event){
        console.log("event is being called in parent "+event.target.value)

       
    
      
    }



    handleClose() {
        this.selectedRecord = undefined;
        this.searchRecords = undefined;
        this.showButton = false;
        const selectedEvent = new CustomEvent('lookup', {
            bubbles: true,
            composed: true,
            cancelable: true,
            detail: {
                data: {
                    record: undefined,
                    recordId: undefined,
                    currentRecordId: this.currentRecordId,
                    parentAPIName: this.parentAPIName,
                    index: this.index
                }
            }
        });
        this.dispatchEvent(selectedEvent);
    }

    titleCase(string) {
        var sentence = string.toLowerCase().split(" ");
        for (var i = 0; i < sentence.length; i++) {
            sentence[i] = sentence[i][0].toUpperCase() + sentence[i].slice(1);
        }
        return sentence;
    }

    handleNewRecord = event => {
        event.preventDefault();
        this.showModal = true;
    }

    handleCancel = event => {
        event.preventDefault();
        this.showModal = false;
    }

    handleSuccess = event => {
        event.preventDefault();
        this.showModal = false;
        let recordId = event.detail.id;
        console.log("here is record id-->"+recordId)
        this.hanleCreatedRecord(recordId);
    }

    hanleCreatedRecord = (recordId) => {
        getRecentlyCreatedRecord({
            recordId: recordId,
            fields: this.fields,
            objectName: this.objName
        })
            .then(result => {
                if (result) {
                    this.selectedRecord = {
                        FIELD1: result[this.field],
                        Id: recordId
                    };
                    const selectedEvent = new CustomEvent('lookup', {
                        bubbles: true,
                        composed: true,
                        cancelable: true,
                        detail: {
                            data: {
                                record: this.selectedRecord,
                                recordId: recordId,
                                currentRecordId: this.currentRecordId,
                                parentAPIName: this.parentAPIName,
                                index: this.index
                            }
                        }
                    });
                    this.dispatchEvent(selectedEvent);
                }
            })
            .catch(error => {
                console.error('Error: \n ', error);
            })
            .finally(() => {
                this.showModal = false;
            });
    }






}