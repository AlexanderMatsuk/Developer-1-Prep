@isTest
public class TestVerifyDate {

    //method to test handling of potential checks against two dates

	@isTest static void testDatesWithinNext30ays() {
		//if date2 is within the next 30 days of date1, use date2.  Otherwise use the end of the month
        //Return end of the month 
        Date date1 = Date.newInstance(2023,4,01);
        Date date2 = Date.newInstance(2023,4,25);
        Date outputDate = VerifyDate.checkDates(date1, date2);
        System.assertEquals(date2, outputDate,'The date2 returned is incorrect');
    }

    @isTest static void testIsLastDateOFTheMonth() {
        //Return date2
        Date date1 = Date.newInstance(2023,4,01);
        Date date2 = Date.newInstance(2023,6,01);
        Date lastDayOfTheMOnth = Date.newInstance(2023,4,30); 
        Date outputDate = VerifyDate.checkDates(date1, date2);
        System.assertEquals(lastDayOfTheMOnth, outputDate,'The end date is incorrect');
	}


}