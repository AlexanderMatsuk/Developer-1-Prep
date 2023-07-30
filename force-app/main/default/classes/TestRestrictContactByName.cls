@isTest
private class TestRestrictContactByName {
    @isTest static void testRestrictContactByIvalidName() {
        // Test data setup
        // Create contacts with an INVALIDNAME, and then try to upsert them
        List<Contact> cntToUpsert = new List<Contact>();
        cntToUpsert.add(new Contact(FirstName = 'First Name', LastName = 'INVALIDNAME'));
        cntToUpsert.add(new Contact(FirstName = 'FirstTestName', LastName = 'LastTestName'));
        List<Contact> cntToUpdate = [SELECT Id, FirstName, LastName FROM Contact WHERE NOT Name LIKE '%INVALIDNAME%' WITH SECURITY_ENFORCED];
        cntToUpsert.get(1).LastName = 'INVALIDNAME';

        // Perform test
        Test.startTest();
        Database.UpsertResult[] upsrList = Database.upsert(cntToUpsert, false);
        Test.stopTest();

        // Verify 
        // In this case the insertion/update should have been stopped by the trigger,
        // so verify that we got back an error.
        for (Database.UpsertResult var : upsrList) {
        System.assert(!var.isSuccess(),'The Contact record insertions has been stopped by the trigger');
        System.assert(var.getErrors().size() > 0,'The Contact record insertions has been stopped by the trigger');
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
                             var.getErrors()[0].getMessage(),'The Contact record insertions has been stopped by the trigger');  
        }
    }
}