trigger AccountTrigger on Account (before update) {
    
    
    if(Trigger.isBefore && Trigger.isUpdate){
        
        
        
        for(Account ac: Trigger.new){
            
            Account oldAc = Trigger.oldMap.get(ac.Id);
            
            if(ac.Name != oldAc.Name){
                ac.AddError('You can\'t chnage the Account Name');
            }
            
        }
    }

}