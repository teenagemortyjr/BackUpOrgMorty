@IsTest
private class getAttacmentTest {
    @IsTest
    static void createTestData() {
       
        ContentVersion newFile = new ContentVersion();
        newFile.PathOnClient = 'TestFile';
        newFile.Title = 'TestFile text';
        newFile.VersionData = Blob.valueOf('sample content');
        insert newFile;
        
		Account ac = new Account() ;
        ac.Name = 'testAc';
		insert ac;        
        
        //Query the contentDocumentId
        ContentVersion insertedFile = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =:newFile.Id];
        
        //Link the file with the product
        ContentDocumentLink linkedFile = new ContentDocumentLink(LinkedEntityId=ac.Id, ContentDocumentId=insertedFile.ContentDocumentId);
        insert linkedFile;
        
        Test.startTest();
        getAttachment.getList();
        Test.stopTest();
    }
}