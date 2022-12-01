import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class QuizApp extends LightningElement {

    selected = {}
    correctAnswer = 2
    score = 50


    submitHandler(event) {
        event.preventDefault();

        console.log("show error");




        ShowToastEvent1()


    }

    ShowToastEvent1() {

        console.log("Toast is working");
        const event = new ShowToastEvent({
            title: 'Game Completed',
            message: 'Your Current Score is ' + this.correctAnswer * this.score,
        });
        this.dispatchEvent(event);
    }






    changeHandler(event) {

        console.log("Name", event.target.value);
        const { name, value } = event.target
        this.selected = {...this.selected, [name]: value }
        ShowToastEvent()
    }



    questionSet = [


        {
            questionId: '1',
            question: "India has largest deposits of ____ in the world.",
            answer: {
                A: "gold",
                B: "copper",
                C: "mica",
                D: "None of the above"

            },

            currentAnswer: 'c'
        },
        {
            questionId: '2',
            question: "Which of the following is used in pencils?",
            answer: {
                A: "Graphite",
                B: "Silicon ",
                C: "Charcoal",
                D: "Phosphorous "

            },

            currentAnswer: 'A'


        }
    ]




}