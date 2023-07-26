public class LeadProcessor implements Database.Batchable<sObject> {
    //query all Lead records
    Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead'
        );
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> leads = new List<Lead>();
        for (Lead leadVar : scope) {
            leadVar.LeadSource = 'Dreamforce';
            leads.add(leadVar);
        }
        update leads;
        recordsProcessed = recordsProcessed + 1;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Batch is completed. Records processed: ' + recordsProcessed);
        
    }

}