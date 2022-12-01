import { LightningElement ,track,wire,api} from 'lwc'; 
import pickListWrapper  from '@salesforce/apex/PickListWrapper.getPickList'
import getCaseStatus from '@salesforce/apex/PickListWrapper.getCaseStatus'




export default class UpdateCaseLWC extends LightningElement { 
    
    @track
    updatCaseIsTrue = false

    @track
    selectedPriorityValue

    @track
    selectedStatusValue  

    @track
    statusLabelList = []

    @track
    priorityLabelList  =[]

    @track
    statusObjArray

    @track
    priorityObjArray

    recordIdOfStage = "5005i00000C1ralAAB"

    defaultStatus 

    @api
    recordId



 


    updateCaseHandler(){ 
        this.updatCaseIsTrue = true
      
        console.log(this.updatCaseIsTrue)  
    } 
   
    

     onPrioritySelected(event){
        this.selectedPriorityValue = event.target.value
        console.log(this.selectedPriorityValue)

     }

     onStatusSelected(event){
        this.selectedStatusValue = event.target.value
        console.log(this.selectedStatusValue)
     }


    get  getStatusLabelList(){

       return  this.statusObjArray


     }

    get getPriorityLabelList(){

        return this.priorityObjArray

    }



    @wire(getCaseStatus,{recordId:'$recordIdOfStage'})
    getStatus({ error, data }){
       if (data) {
        
           this.defaultStatus = data;
           console.log("default satus -->"+this.defaultStatus)
           console.log("record Id"+this.recordId)
       } else if (error) {
           console.log("Error is here"+error);
           
       }
    }



    changeStatus(){

        if(this.defaultStatus != undefined){
            console.log("value has been chnaged changeStatus")
            this.selectedStatusValue = this.defaultStatus
           
        }
    }


   

    



connectedCallback(){
console.log("connect call back called")

    pickListWrapper().then(Response =>{
        //this.statusLabelList = Response.statusList
       // this.priorityLabelList = Response.priorityList 
        console.log("staus value --->"+this.statusLabelList)
        console.log("priorityLable ---->"+Response.priorityList)  

        for(var key in Response.priorityList){
            this.priorityLabelList.push({label:Response.priorityList[key], value:Response.priorityList[key]});
        }



        for(var key in Response.statusList){
            this.statusLabelList.push({label:Response.statusList[key], value:Response.statusList[key]});
        }

        
        console.log("obj is here"+this.priorityLabelList)

        
        console.log("obj is here"+this.statusLabelList)
    }).catch(error => {
        console.log("got error -->"+error);
        console.log(error)
    })
    


   
  



    
}


    





    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.updatCaseIsTrue = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        changeStatus()
        this.updatCaseIsTrue = false;
    }





}