import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import login_icon from '@salesforce/resourceUrl/login_icon';

export default class StyleLWC extends NavigationMixin(LightningElement) {

    saleforceLogo = login_icon;


    handleClick(event) {

        var defination = {
            componentDef: 'c:quizApp'
        }

        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/one/one.app#' + btoa(JSON.stringify(defination))
            },
        });

    }


}