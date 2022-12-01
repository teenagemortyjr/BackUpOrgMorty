import { LightningElement } from 'lwc';

export default class ChangeFontLwc extends LightningElement {
    count = 0;

    connectedCallback() {
      
        this.count = localStorage.getItem('current_Count')
            ? localStorage.getItem('current_Count')
            : 0;
    }

    increaseCount(event){
        console.log('count'+this.count)
        this.count++
        localStorage.setItem('current_Count',this.count)
        
    }

    get getFontSize(){
        console.log('called font size')
        return `font-size: ${this.count}px`;
    }

}