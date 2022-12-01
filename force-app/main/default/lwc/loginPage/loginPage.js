import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';
import { LightningElement } from 'lwc';

export default class LoginPage extends LightningElement {
  backgoundImg = ''
    runOnLoad(){
  let  backgroundList = ['https://img.freepik.com/free-vector/job-interview-conversation_74855-7566.jpg?w=1380&t=st=1669813155~exp=1669813755~hmac=c3aae34130ff0bceaa67dca0e6912f29d536f6bb3304e5cbd60ebc99cfc211ef',
        'https://img.freepik.com/free-vector/multitasking-concept-illustration_114360-3557.jpg?w=1380&t=st=1669815134~exp=1669815734~hmac=410e7b33679a4948602d78b1c924d12bc49edb25fc7677003ab8b0491985bf9f',
        'https://img.freepik.com/free-vector/team-goals-concept-illustration_114360-5175.jpg?w=826&t=st=1669815259~exp=1669815859~hmac=ade52fbaa0b1e2345531d8acf193ce6cbe5a8a171524f53aed62ab62d4d7735d',
        'https://img.freepik.com/free-vector/work-anniversary-concept-illustration_114360-7791.jpg?w=1380&t=st=1669815291~exp=1669815891~hmac=a8500ac23e8b4ff907d08d2e05389d8a1633437055ca026e1ba0749c880e315e',
      'https://img.freepik.com/free-photo/happy-professional-asian-female-manager-businesswoman-suit-showing-announcement-smiling-pointing-finger-left-product-project-banner-standing-white-background_1258-69508.jpg?w=1380&t=st=1669884168~exp=1669884768~hmac=caf068155adcf16bc19b56f13f2e6749fccd12810f9c30945f41ae333955122a',
    'https://img.freepik.com/free-vector/corporate-portrait-office-workers-employees_74855-5471.jpg?w=1380&t=st=1669884296~exp=1669884896~hmac=cab8f2f6d7e371a71e019f7324363855791fa394aa9d9952dd4f07c196d74611',
  'https://img.freepik.com/free-vector/choosing-best-candidate-concept_52683-43377.jpg?w=1380&t=st=1669884365~exp=1669884965~hmac=ea5bde9eb70f9d320651ffbd2fc5dc1129b650c9579cb143beaa3efa6f06f662'
]

  let  x = Math.random()*6;
  console.log('x-->'+Math.trunc( Math.floor(x)));
  console.log('background'+backgroundList[Math.trunc( Math.floor(x))])
  this.backgoundImg = backgroundList[Math.trunc( Math.floor(x))];
    }

    connectedCallback(){
        this.runOnLoad();
    }

    get getBackground(){
        this.backgoundImg =  `background-image: url(${this.backgoundImg})`;
        return this.backgoundImg;
    }

}