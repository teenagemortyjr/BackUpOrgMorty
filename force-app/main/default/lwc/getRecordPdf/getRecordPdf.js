import { LightningElement, track, api } from 'lwc';
import getObjectList from '@salesforce/apex/defaultApex.getAllObjectNameList' ;
import getObjField from '@salesforce/apex/defaultApex.returnApi' ;
import getLookUpList from '@salesforce/apex/defaultApex.getLookUpList' ;
import getRecord from '@salesforce/apex/defaultApex.getAllRecord' ;
import {loadScript} from "lightning/platformResourceLoader";
import JSPDF from '@salesforce/resourceUrl/jspdf';

export default class GetRecordPdf extends LightningElement {

    
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
    @track isRecordAvailable = false

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
    @track allRecord


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

    jsPdfInitialized = false
	headers = []



    handleInputChange(event){
        console.log(" name ---->  "+event.target.value)

    }

   

    handleChange(event) {

        this.lstSelected = event.detail.value;
        console.log("select value is" + this.lstSelected)
    
        this.isRecordAvailable = true

    }





    onSelectObject(event) {

        this.selectedObject = event.target.value
        this.objName = this.selectedObject
        console.log(this.selectedObject + "object os jere")



        // let icons = this.iconName.split(':');
        // this.ICON_URL = this.ICON_URL.replace('{0}', icons[0]);
        // this.ICON_URL = this.ICON_URL.replace('{1}', icons[1]);

       




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



   

   


    onRecordSelect(event){
        console.log("event -->"+event)
        console.log("on record selecrt +"+event.target.value)
    }

   
    
        
    



    handleNewRecord = event => {
        event.preventDefault();
        this.showModal = true;
    }

    handleCancel = event => {
        event.preventDefault();
        this.showModal = false;
    }

 


    renderedCallback(){
        if (this.jsPdfInitialized) {
            return;
        }
        this.jsPdfInitialized = true;

        Promise.all([
            loadScript(this, JSPDF)
        ]);
    }
	generatePdf(){
        console.log("inside generate pdf");

        try{
		const { jsPDF } = window.jspdf;
        console.log("inside generate pdf1");

		const doc = new jsPDF('l', 'pt', 'a4');
        doc.setFont("helvetica");
        doc.setFontSize(1);
        console.log("inside generate pdf2");

		//doc.text(this.selectedObject+" Table", 10, 10);
        console.log("all record before insert"+JSON.stringify(this.allRecord,null,'\t'))
        //console.log("all header -->"+JSON.stringify(this.headers,null,'\t'))
        console.log("list od string=>"+this.lstSelected)
        let config_styles = {
            autoSize: true
          }
		doc.table(10, 10, this.allRecord, this.lstSelected, config_styles);
		doc.save("demo2.pdf");
        
    }catch(err){
        console.log("the error ---->"+err)
    }
    
    }
	


	generateData(){
		getRecord({objectType: this.selectedObject, fieldList: this.lstSelected}).then(result=>{
			this.allRecord = result;
            console.log("Record List List-->"+JSON.stringify(this.allRecord));
			this.generatePdf();
		});
	}

	createHeaders(keys){
        console.log("inside the create header-->"+keys)
		var result = [];
		for (var i = 0; i < keys.length; i += 1) {
			result.push({
				id: keys[i],
				name: keys[i],
				prompt: keys[i],
				width: 65,
				align: "center",
				padding: 0
			});
		}
		return result;
	}



    /////   Generating PDF===================>


convertToPDF(){
    console.log('inner pdf conversion');
    try{
        console.log('Enter in try =======>');
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        var head=[];
            console.log("::18");
        console.log('::18 selectedOptionsList'+this.selectedOptionsList);
       
        head = this.selectedOptionsList;
        console.log('Head values===='+head);
        console.log('Head values===='+typeof head);
      
        console.log("pdfobject==>"+JSON.stringify(this.recordArray));
        //let head = ['First_Name', 'Last_Name','Title', 'Organization'];
        let headerConfig = head.map(key=>({ 
            name: key,
            'prompt': key,
            'width':20, 
            'align':'center',
            'padding':0}));
        console.log("::35");
        doc.table(1, 2,this.recordArray,head,{});


        console.log('Table====>'+doc.table(1, 2,this.recordArray,head,{autosize:true,
            margins:5,fontSize:4}));
            console.log('line number 36');
        console.log('Table====>'+ JSON.stringify(doc.table(1, 2,this.recordArray,head,{})));
        var blob = new Blob([doc.table(1, 2,this.recordArray,head,{autosize:true,
            margins:5,fontSize:4})], { type: 'application/pdf' });
        console.log('Blob Data======>'+blob);
       // console.log('Blob Data======>'+JSON.stringify(blob));
    
       this.downloadData =  doc.save("get.pdf");
        console.log('Save Data====>'+this.downloadData);
        console.log('Save Data====>'+JSON.stringify(this.downloadData));

    }catch(e){
        console.log("ERROR==>"+e);
    }


}

}