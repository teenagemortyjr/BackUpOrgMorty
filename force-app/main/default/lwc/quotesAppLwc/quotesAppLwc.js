import { LightningElement, track } from 'lwc';
import quotes from '@salesforce/resourceUrl/quotes'


export default class QuotesAppLwc extends LightningElement {

    temp = "A marriage anniversary is the best day to celebrate so many things like love, trust, envy, partnership, tolerance, and quarrels and this list goes on till it becomes like, “well, we don’t have anything new to celebrate, so for what else we can celebrate this day now?” HaHa, just kidding. Anyway, enjoy your lovely day and always keep smiling. Happy Anniversary!"
    quotesData
    quotesString = ""

    @track quotesArr = []

    @track index = 0

     get nextBtnVisible(){

        return !(this.index == this.quotesArr.length-1)

     } 

   get prevBtnVisible(){

    return !(this.index <0 || this.index == 0 )


   }




    

    @track currentQuote = "A marriage anniversary is the best day to celebrate so many things like love, trust, envy, partnership, tolerance, and quarrels and this list goes on till it becomes like, “well, we don’t have anything new to celebrate, so for what else we can celebrate this day now?” HaHa, just kidding. Anyway, enjoy your lovely day and always keep smiling. Happy Anniversary!"

    

    get nextBtnDisabled(){
        

        return !(this.index<this.quotesArr.length-1)
    }

    get prevBtnDisabled(){
     
        return !(this.index!=0)

    }
    prevQuoteHandler(event) {
        if(this.index == 0){
            console.log(
            "can't go back"
            )
            this.prevBtnVisible = false

         
        }else{

            this.index--
        console.log("index valuev " +this.index)
        this.currentQuote = this.quotesArr[this.index]
        console.log("current Quote " + this.currentQuote)
            
        }


    }


    nextQuoteHandler(event) {
        console.log("clck me newxr")
        if(this.index == this.quotesArr.length-1){
            this.nextBtnVisible = false
            
            console.log("can't go further")
            
        }else{
        this.index++
        console.log("index valuev " +this.index)
        this.currentQuote = this.quotesArr[this.index]
        console.log("current Quote " + this.currentQuote)
        }
    }


    setDataInArray() {
        this.quotesArr.push(this.temp)

        let onePragraph = ""
        let spaceCount = 0


        for (let i = 0; i < this.quotesString.length; i++) {

            if (this.quotesString[i] != '!') {

                onePragraph = onePragraph + this.quotesString[i];


            } else if (this.quotesString[i] == '!') {
                console.log("paragraph------>" + onePragraph)
                this.quotesArr.push(onePragraph)
                onePragraph = ""


            }


        }



    }













    connectedCallback() {

        fetch(quotes)
            .then(response => response.text())
            .then(quotesData => {
                this.quotesString = quotesData
               // console.log("quotes strign" + this.quotesString)
                this.setDataInArray()
            })






    }









}