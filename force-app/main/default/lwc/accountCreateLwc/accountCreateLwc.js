import { LightningElement,track } from 'lwc';




const columns = [
    { label: 'Account Name', fieldName: 'name' },
    { label: 'Account Site', fieldName: 'Account Site', type: 'url' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Account Owner Alias', fieldName: 'Account Owner Alias' }

];


export default class AccountCreateLwc extends LightningElement {

    columns = columns;


    data = [{Name:"asfsaifiad",
           sajfjsaf:"saijfiasjf",
        ijasfoijsaiofjis:"oijasoifja",
    oisajfjsafioj:"isjfiaojf"}

,
    {mohna:"asfsaifiad",
    sajfjsaf:"saijfiasjf",
 ijasfoijsaiofjis:"oijasoifja",
oisajfjsafioj:"isjfiaojf"}]


}