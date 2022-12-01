import {LightningElement} from 'lwc';
import {loadScript} from "lightning/platformResourceLoader";
import JSPDF from '@salesforce/resourceUrl/jspdf';
import getContacts from '@salesforce/apex/defaultApex.getContactsController';


export default class PdfGeneration extends LightningElement{

    contactList = [];
    jsPdfInitialized = false
	headers = this.createHeaders([
		"Id",
		"FirstName",
		"LastName"
	]);

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
		const { jsPDF } = window.jspdf;
		const doc = new jsPDF();

		doc.text("Contact Table", 10, 10);
        console.log("here is conList-->"+this.contactList)
        console.log("all header -->"+this.headers)
		doc.table(2,2 , this.contactList, this.headers, { autosize:true });
		doc.save("demo.pdf");
	}

	generateData(){
		getContacts().then(result=>{
			this.contactList = result;
            console.log("contact List-->"+JSON.stringify(this.contactList));
			this.generatePdf();
		});
	}

	createHeaders(keys) {
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
   

   

}