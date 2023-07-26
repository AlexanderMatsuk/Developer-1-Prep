@isTest
public class AddPrimaryContactTest {
    
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        // add 50  accounts with BillingState NY and CA
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i, BillingState = 'NY'
            ));
            Integer j = i+ 50;
            accounts.add(new Account(
                name='Test Account'+j, BillingState = 'CA'
            ));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        String state = 'CA';
        Contact cont = new Contact(LastName = 'QWERTY Contact Test');
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact (cont, state);
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        // Validate that a Contact record was inserted for each of the 50 Accounts with the BillingState of CA
        System.assertEquals(50, [select count() from Contact where Account.BillingState = :state]);
    }

}