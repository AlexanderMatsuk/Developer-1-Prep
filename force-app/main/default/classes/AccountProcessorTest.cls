@isTest
private class AccountProcessorTest {
    
    @isTest
    private static void countContactsTest(){
        //Load Test data
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<300; i++){
            accounts.add(new Account(Name='Test Account' + i, Type = 'Other'));
        }
        Database.insert(accounts, true) ;
        
        List<Contact> contacts = new List<Contact>();
        List<Id> accountIds = new List<Id>();
        for (Account var : accounts){
            contacts.add(new Contact(FirstName = var.Name, LastName = 'Test Contact', AccountId = var.Id));
        	accountIds.add(var.Id);
        }
        insert contacts;
        //Do the Test
        Test.startTest();
        
        AccountProcessor.countContacts(accountIds);
            
        Test.stopTest();
        
        //Check the Result
   		List<Account> assertedAccs = [SELECT Id, Number_Of_Contacts__c  
                                      FROM Account];
        for(Account var : assertedAccs){
            System.assertEquals(1, var.Number_Of_Contacts__c, 'ERROR: At least 1 Account record with incorrect num of Contacts');
        }
    
    }

}