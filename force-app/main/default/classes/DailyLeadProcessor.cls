public class DailyLeadProcessor implements Schedulable {
	public void execute(SchedulableContext ctx) {
        List<Lead> leads = new List<Lead>();
        for (Lead var : [SELECT Id, LeadSource
                        FROM Lead
                        WHERE LeadSource = ''
                         LIMIT 200]){
            var.LeadSource = 'Dreamforce';
            leads.add(var);
                             
        }
        update leads;
        
        
    }

}