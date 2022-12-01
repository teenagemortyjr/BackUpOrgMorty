import { LightningElement, track,wire } from 'lwc'
import getUsers from '@salesforce/apex/defaultApex.getUserList'
import getUserPermissionSet from '@salesforce/apex/defaultApex.getUserPermissionSet'
import setPermission from '@salesforce/apex/defaultApex.setPermission'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';






export default class UserLWC extends LightningElement {




    @track
    userNameList= []

    secondUserList = []

    @track 
    userNameList2 = []
    @track
    user1Detail ;
    @track
    user2Detail = {}
    @track
    user1Profile = {}
    @track
    user2Profile = {}
    @track
    userList
    @track
    user1ProfileId
    @track
    user2ProfileId
    @track
    selectedUserNameFromCombobox1
    @track
    selectedUserNameFromCombobox2

    userPermissionSetList2

    @track
    isUserListEmpty = false

    userPermissionSetList = []
    lstSelected = []

   




showToast() {

    console.log('inside the toast')
    const event = new ShowToastEvent({
        title: 'Toast message',
        message: 'Toast Message',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(event);
}


     handleChange(event){

        this.lstSelected = event.detail.value;
        console.log("select value is" + this.lstSelected)
        let tempNameList = []
        for (var key in this.lstSelected) {
            console.log(`key--${this.lstSelected[key]}   fieldName-->${this.lstSelected[key]}`);
            tempNameList.push({ label: this.lstSelected[key], fieldName: this.lstSelected[key] });
        }

     }


    


    onCombobox1Click(event){
        this.selectedUserNameFromCombobox1 = event.target.value
        this.isUserListEmpty = true
        console.log(this.selectedUserNameFromCombobox1)


      
console.log('till here its working')

       

        console.log('this.userNameList2'+this.secondUserList)
        //console.log(JSON.stringify(this.secondUserList))

       

       getUserPermissionSet({userName: this.selectedUserNameFromCombobox1}).then(result=>{
        console.log("PermissionList list -->" + (result))
        this.user1Profile = result

        let tempNameList = []
            for (var key in result) {
                console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push({ label: result[key], value: result[key] });
            }
            this.userPermissionSetList = tempNameList


       } )
       .catch(error => {
           console.log("Error is here" + error)
       })
      
    }


    onCombobox2Click(event){

       this.selectedUserNameFromCombobox2 = event.currentTarget.value

       getUserPermissionSet({userName: this.selectedUserNameFromCombobox2}).then(result=>{
        console.log("PermissionList list -->" + (result))
 
            
        let tempNameList = []
            for (var key in result) {
               // console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push(result[key]);
            }
            this.userPermissionSetList2 = tempNameList
            console.log('user permission set2 '+this.userPermissionSetList2)



       } )
       .catch(error => {
           console.log("Error is here" + error)
       })


    
    }





    onTransferPermissionSetClick() {

        console.log("clicked on transfer permission set")


        
       setPermission({ permissionSetList: this.lstSelected, userName: this.selectedUserNameFromCombobox2})

       
        this.showToast()


        getUserPermissionSet({userName: this.selectedUserNameFromCombobox2}).then(result=>{
        console.log("PermissionList list -->" + (result))
 
            
        let tempNameList = []
            for (var key in result) {
               // console.log(`key--${result[key]}   value-->${result[key]}`);
                tempNameList.push(result[key]);
            }
            this.userPermissionSetList2 = tempNameList
            console.log('user permission set2 '+this.userPermissionSetList2)



       } )
       .catch(error => {
           console.log("Error is here" + error)
       })

      
    }


    connectedCallback() {

        getUsers()
            .then(result => {
                console.log("user list -->" + JSON.stringify(result))
                this.secondUserList = result
                

                let optionvalues = [];
                console.log("user complete detail --->"+result)


                for (var key in result){
                    console.log(`key--${result[key]}   value-->${result[key]}`);

                    optionvalues.push({label: result[key], value: result[key]});

                }
                this.userNameList=optionvalues
                this.userNameList2 = optionvalues

                console.log("here is List-->" + JSON.stringify(this.userNameList))
                


            })
            .catch(error => {
                console.log("Error is here" + error)
            })







    }



}