import StartDate from '@salesforce/schema/Contract.StartDate';
import { LightningElement, track } from 'lwc';




export default class TimerLwc extends LightningElement {


    @track showStartBtn = true;
    @track timeVal = '0:0:0:0';
    timeIntervalInstance;
    totalMilliseconds = 0;
    emptyVar



    connectedCallback() {
        console.log("emtpy variable-->"+this.emptyVar)

        this.showStartBtn = false;
        var parentThis = this;

        this.timeIntervalInstance = setInterval(function() {



            let time = new Date();
            let hour = time.getHours();
            let min = time.getMinutes();
            let sec = time.getSeconds();
            let am_pm = " PM";

            if (hour > 12) {
                hour -= 12;
                am_pm = " PM";
            }
            if (hour == 0 ) {
                hr = 12;
                am_pm = " AM";
            }

            if(hour <12){
                am_pm = " AM";
            }

            hour = hour < 10 ? "0" + hour : hour;
            min = min < 10 ? "0" + min : min;
            sec = sec < 10 ? "0" + sec : sec;

            let currentTime = hour + ":" +
                min + ":" + sec + am_pm;
            this.timeVal = currentTime;

            console.log(currentTime);
            parentThis.timeVal = currentTime;


        }, 100);



    }
    stop(event) {
        this.showStartBtn = true;
        clearInterval(this.timeIntervalInstance);
    }

    reset(event) {
        this.showStartBtn = true;
        this.timeVal = '0:0:0:0';
        this.totalMilliseconds = 0;
        clearInterval(this.timeIntervalInstance);
    }
}