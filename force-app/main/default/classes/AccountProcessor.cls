public class AccountProcessor {
    @future
    public static void countContacts(List<Id> recordIds){
        List<Account> listToUpdate = [SELECT Id, (SELECT Id FROM Contacts)  
                                      FROM Account 
                                      WHERE Id IN :recordIds];
        
        for (Account var : listToUpdate){
          var.Number_Of_Contacts__c = var.Contacts.size();
        }
        update listToUpdate;

        
    }

}