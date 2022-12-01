import { LightningElement,track } from 'lwc';

export default class SnakeGameLwc extends LightningElement {
    score = 0;
    blockSize = 20;
    @track gameBlocks = [];
    renderComplete = false;

    xSpeed = 1;
    ySpeed = 0;

    xHead = 0;
    yHead = 0;

    xMax ;
    yMax ;

    startGame(){
        setInterval( ()=> {
            this.move();
        },300);
    }

    move(){
        let curPosition = this.gameBlocks.findIndex(x => x.id === `${this.xHead}:${this.yHead}`);
        this.gameBlocks[curPosition].snake = false
        this.gameBlocks[curPosition].class = ''

        this.xHead += this.xSpeed;
        this.yHead += this.ySpeed;

        if(this.xHead >= this.xMax){
            this.xHead = 0;
            console.log('y max value --?='+this.yHead)
        }

        if(this.xHead < 0){
            this.xHead = this.xMax - 1;
            console.log('y max value --?='+this.yHead)
        }

        if(this.yHead >= this.YMax){
            this.yHead = 0;
            console.log('y max value --?='+this.yHead)
        }

        if(this.yHead < 0){
            this.yHead = this.yMax - 1;
            console.log('y max value --?='+this.yHead)
        }


        let newPosition = this.gameBlocks.findIndex(x => x.id === `${this.xHead}:${this.yHead}`);
        this.gameBlocks[newPosition].snake = true;
        this.gameBlocks[newPosition].class = 'snake';

        if(this.gameBlocks[newPosition].food){
            this.score++;
            this.gameBlocks[newPosition].food = false;
            this.generateFood();

        }

        

    }


    generateFood(){
        let xFood = Math.floor(Math.random() * this.xMax);
        let yFood = Math.floor(Math.random() * this.yMax);
        
        
        let foodPosIndex = this.gameBlocks.findIndex(x => x.id === `${xFood}:${yFood}`);
        this.gameBlocks[foodPosIndex].food = true;
        this.gameBlocks[foodPosIndex].class = 'food';
    }

    keyBoardControls(){
        window.addEventListener('keydown',(e)=>{
            e.preventDefault();
            console.log(e);

            switch(e.key){
                case "ArrowUp":
                    this.xSpeed = 0;
                    this.ySpeed = -1;
                    break;
                case "ArrowDown":
                    this.xSpeed = 0;
                    this.ySpeed = 1;
                    break;
                    
                case "ArrowLeft":
                    this.xSpeed = -1;
                    this.ySpeed =  0;
                    break;

                case "ArrowRight":
                    this.xSpeed = 1;
                    this.ySpeed = 0;
                    break;
            }
        })
    }

    renderedCallback(){
        if(!this.renderComplete){
            let eWidth = this.template.querySelector(".game-container").clientWidth;
            let eHight = this.template.querySelector(".game-container").clientHeight;
    
           // console.log('eWidth-->'+eWidth+' '+'eHight--->'+eHight);
    
           this.xMax = Math.floor(eWidth/this.blockSize);
           this.yMax = Math.floor(eHight/this.blockSize);
        
           let tempBlock = []
    
           for(let y=0;y< this.yMax; y++){
                for(let x = 0; x< this.xMax; x++){
                    let obj;
                    if(x==0 && y==0){
                        obj = {id: `${x}:${y}`, snake: true, food: false,class: 'snake'};
                    }else{
                       obj = {id: `${x}:${y}`, snake: false, food: false,class: ''};
                    }
                    
                    tempBlock.push(obj);
                }
           }
           this.renderComplete = true
           this.gameBlocks = tempBlock
           this.keyBoardControls();
           this.generateFood();
           this.startGame();
          

        }
    
    }
}