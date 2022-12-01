import { LightningElement,api, wire } from 'lwc'
import allAccountWithContact from '@salesforce/apex/defaultApex.allAccountWithContact'



export default class ExperimentLwc extends LightningElement {

    gridData = []

    @wire(allAccountWithContact)
    accountsWithContactsResult({data,error}){
        if(data){
            this.formatGridData(data)
            console.log("data"+JSON.stringify(data))
        }if(error){
            console.error(error)
        }
    }

    
    //columns

    girdColumns=[
        {
            label:'Name',
            fieldName:'Name',
            type:'text'
        },

        {
            label:'Phone',
            fieldName:'Phone',
            type:'text'
        },

        {
            label:'Account Website',
            fieldName:'Website',
            type:'url',
            typeAttributes:{
                target:'_blank'
            }
        }


    ]

    formatGridData(result){

      this.gridData =  result.map(item=>{
            const {Contacts, ...accounts} = item
            return {...accounts,"_children":Contacts}
        })

        console.log('grid Data->'+JSON.stringify(this.gridData))
    }


    
}