public class IntStrWrapper {
    
    // public IntStrWrapperClass objIntStr{get;set;}
    
    public static IntStrWrapperClass IntStrWrapper1(){
        
      IntStrWrapperClass  objIntStr = new IntStrWrapperClass();
      	objIntStr.acNum = 'accoount505';
       // objIntStr.intNum = 54521221;        
        system.debug('wrapper class-->'+objIntStr);
       
        account acc =  new account();
        acc =[SELECT Id , Name from account limit 1];
       objIntStr.intNum = acc;
         return objIntStr;
    } 
    
    public class IntStrWrapperClass{
        
        public String acNum {get;set;}
        public account intNum {get;set;}
    }
    
    

}