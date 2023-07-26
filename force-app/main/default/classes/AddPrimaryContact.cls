public class AddPrimaryContact implements Queueable {
    Contact cnt;
    String state;
    public AddPrimaryContact (Contact param1, String param2){
        cnt = param1;
        state = param2;  
    }
    
    public void execute(QueueableContext context) {
        List <Contact> cnts = new List <Contact>();
        for (Account accs :[SELECT Id FROM Account WHERE BillingState =: state LIMIT 200]){
            Contact dupContact = cnt.clone(false, false, false, false);
            dupContact.AccountId = accs.Id;
            cnts.add(dupContact);
        }
        insert cnts;
    }
}