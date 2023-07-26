@isTest
public class DailyLeadProcessorTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 5 * * * ?';
    
    @IsTest
    static void testScheduledJob() {
        
        List<Lead> leads = new List<Lead>();

        for (Integer i=0; i<200; i++) {
            Lead ld = new Lead(LastName = 'Test Lead ' + i, Company='Test Company '+ i);
            leads.add(ld);
        }
        insert leads;

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new DailyLeadProcessor());
        
        Test.stopTest();
        
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);

    }

}