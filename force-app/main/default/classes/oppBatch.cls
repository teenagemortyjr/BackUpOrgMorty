global class oppBatch implements Database.Batchable<sObject>{
    
    
    global  List<Opportunity> start(Database.BatchableContext BC) {
        
        List<Opportunity> opList = new List<Opportunity>();
        
        for(Integer i=0;i<5;i++){
        Opportunity op = new Opportunity();
        Date d = date.today();
        op.Name = 'new opp'+String.valueOf(d);
        op.CloseDate = d.addDays(100);
        op.StageName = 'Qualification';
        opList.add(op);
           
          }
        
        return opList;
       
        
    }
     
    
   
     
    global void execute(Database.BatchableContext BC,List<Opportunity> opList ){
        
        if(!opList.isEmpty()){
            insert opList;
            system.debug('Opportunity List is getting inserted--->');
        }
      
    }
    

        
       
    global void finish(Database.BatchableContext BC){
       system.debug('task has been finished');
    }
}