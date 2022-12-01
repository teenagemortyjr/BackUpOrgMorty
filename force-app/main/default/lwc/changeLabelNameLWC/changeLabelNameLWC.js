import { LightningElement,track } from 'lwc';
import getCustomObjectList from '@salesforce/apex/defaultApex.getAllCustomObjectNameList'
import getObjField from '@salesforce/apex/defaultApex.returnApi'


export default class ChangeLabelNameLWC extends LightningElement {

    @track
    customObjectNameList

    @track
    selectedObject

    @track
    customeObjectFieldList 

    @track
    lstSelected = [];

    @track isModalOpen = false;

    @track
    fieldListContainValue = false


    handleChange(event){

        this.lstSelected = event.detail.value;
        console.log("select value is"+this.lstSelected)
        this.fieldListContainValue = true
    }

    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = true;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }


    onSelectObject(event){
        this.selectedObject = event.target.value
        console.log(this.selectedObject+"object os jere")

        getObjField({fieldName: this.selectedObject}).then(result=>{

         
           

            let tempNameList = []
            for (var key in result){
                console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push({label: result[key], value: result[key]});
            }
            this.customeObjectFieldList = tempNameList



        }).catch(errorv=>{
            console.log("Error is here" + JSON.stringify(error))

        })


    }


    connectedCallback(){
        getCustomObjectList().then(result=>{
            console.log("result -->"+JSON.stringify(result))
         
            let tempNameList = []
            for (var key in result){
                console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push({label: result[key], value: result[key]});
            }

            this.customObjectNameList = tempNameList
            console.log("-----"+this.customObjectNameList)


        }) .catch(error => {
            console.log("Error is here" + JSON.stringify(error))
        })

    }


}