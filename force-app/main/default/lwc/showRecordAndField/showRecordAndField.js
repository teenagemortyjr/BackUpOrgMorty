import { LightningElement, track} from 'lwc';
import getObjectList from '@salesforce/apex/defaultApex.getAllObjectNameList' ;
import getObjField from '@salesforce/apex/defaultApex.returnApi' ;

export default class ShowRecordAndField extends LightningElement {

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

    

    @track error;
    @track objectRecordId


    searchRecords;
    selectedRecord;
    objectLabel;
 

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

       

    }

  



    onSelectObject(event) {

        this.selectedObject = event.target.value
        this.objName = this.selectedObject
        console.log(this.selectedObject + "object os jere")




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



 




}