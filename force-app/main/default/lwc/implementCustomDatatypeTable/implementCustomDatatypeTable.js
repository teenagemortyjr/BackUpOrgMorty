import { LightningElement } from 'lwc';

export default class ImplementCustomDatatypeTable extends LightningElement {

    cols=[
        {lablel: 'CheckList Name',fieldName:'Name'},
        {lablel: 'CheckList Name2',fieldName:'Phone'},
        {lablel: 'CheckList Name3',fieldName:'avgHealthScore',type:'progressRing'}
    ]

    data = [{
        Id:'shfksaf4564151',
        Name:'Rishav',
        Phone:'45415151515',
        avgHealthScore:'Good'

    }]
}