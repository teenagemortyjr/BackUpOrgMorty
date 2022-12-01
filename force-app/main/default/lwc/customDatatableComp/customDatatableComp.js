import { LightningElement } from 'lwc'
import progressRing from './progressRing.html'

export default class CustomDatatableComp extends LightningDatatable {

    static customTypes={
        proRing:{
            template:progressRing
        }
    }
}