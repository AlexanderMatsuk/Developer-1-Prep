public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts (Integer numOfContacts, String lastName) {
        List<Contact> cntcts = new List<Contact>();
        for(Integer i = 0; i < numOfContacts; i++) {
            Contact a = new Contact (FirstName='TestContact' + i, LastName = lastName);
            cntcts.add(a);
        }
        insert cntcts;

        return cntcts;
    }
}