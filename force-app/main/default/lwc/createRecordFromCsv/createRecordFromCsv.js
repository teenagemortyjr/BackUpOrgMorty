import { LightningElement,track } from 'lwc';
import getCustomObjectList from '@salesforce/apex/defaultApex.getAllCustomObjectNameList' ;
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import loadData from '@salesforce/apex/defaultApex.loadData';
import getField from '@salesforce/apex/defaultApex.returnApi';






export default class CreateRecordFromCsv extends LightningElement {
    

    @track
    ObjectNameList

    @track
    RecordString 

    @track
    isFieldAvailable = false


    @track
    ObjectFieldList

    @track
    objectFieldInCsv = ['Name','Site','Account Source','LastName','bakc']

    @track
    selectedObject = 'Object Name'

    error
    isLoaded = false;

    @track
    allHeaderList 

    get acceptedFormats() {
        return ['.csv'];
    }
    
    uploadFileHandler(event){
        
        this.isLoaded = true;
        const uploadedFiles = event.detail.files;

        loadData( { contentDocumentId : uploadedFiles[0].documentId } )
        .then( result => {
            this.RecordString = result.headerList;
            console.log('RecordString'+this.RecordString)
            let word  =''
            let hList = []
            for(let i=0;i<this.RecordString.length;i++){
                if(this.RecordString[i]!=','){
                    if(word== ''){
                        word = this.RecordString[i]
                    }else{
                        word = word+this.RecordString[i]
                    }
                }else{
                    hList.push(word)
                    word = ''
                }

            }
            hList.push(word)
            this.allHeaderList = hList;
            console.log("here is final list--->"+this.allHeaderList)
            this.isFieldAvailable = true

            this.isLoaded = false;
            window.console.log('result ===> '+result);
            this.strMessage = result.getMsg;
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Success',
                    message: result,
                    variant: result.includes('success') ? 'success' : 'error',
                    mode: 'sticky'
                }),
            );

        })
        .catch( error => {

            this.isLoaded = false;
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Error!!',
                    message: JSON.stringify( error ),
                    variant: 'error',
                    mode: 'sticky'
                } ),
            )

        } )

    }




    onSelectObject(event) {

        this.selectedObject = event.target.value
        console.log(this.selectedObject + "object is Here")


        getField({ fieldName: this.selectedObject }).then(result => {

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

        getCustomObjectList().then(result => {
            console.log('result -->'+ JSON.stringify(result));

            let tempNameList = [];
            for (var key in result) {
                console.log('Key-check-'+key);
                console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push({ label: result[key], value: result[key] });
            }

            this.ObjectNameList = tempNameList ;
            console.log('customObjectNameList -->>'+this.customObjectNameList.length);


        }).catch(error => {
            console.log("Error is here" + JSON.stringify(error))
        })



    }




}