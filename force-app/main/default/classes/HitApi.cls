@RestResource(urlMapping='/TaskSubmit/')
global class HitApi {
    @HttpPost
    global static void start(){
        
        string taskNumber = '';
        List<String> responseList = new List<String>(); 
   
            
            RestRequest req = RestContext.request;
                system.debug('req-->'+req);

            map<string,object> msg = (map<string,object>)JSON.deserializeUntyped(req.requestBody.tostring());
                system.debug('msg-->'+msg);

            map<string,object> inMsg=(map<string,object>)msg.get('Message');
                system.debug('inMsg-->'+inMsg);

            
            map<string,object> c = (map<string,object>)inMsg;
                system.debug('c-->'+c);

            taskNumber = string.ValueOF(c.get('Task'));
        system.debug('taskNumber-->'+taskNumber);
            //if(taskNumber != null)
                //outMsg = SubmitTask(c);
            
            //outMsg.TaskNumber = taskNumber;
        
    }

}