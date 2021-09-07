///////////////////////////////////////////////////////////////
//
// Name: emailTriggerHandler
// Author: Jordan Gaten, Team Synergy
// Created: 08/29/21
// Updated: 08/31/21
// Description: Handler logic for PaymentTrigger.
//
///////////////////////////////////////////////////////////////
public class emailTriggerHandler{
    public static List<Passanger_Accounts__C> FlightSet(List<Passanger_Accounts__c> newEmails) {
        
        Set<Passanger_Accounts__c> FlightMembersSet = new Set<Passanger_Accounts__c>();
        // Loop iterating query for email and name fields from the passanger account object
        //
 for (List<Passanger_Accounts__c> e : [SELECT email__c FROM Passanger_Accounts__c]) {
            
            //Set that will hold the name and emails for Flight members 
            //
           
         
            //

            //// If statement that adds the records from the query if the field is not empty
            //
            if(e != Null) {
                insert e;
            newEmails.addAll(e);
                
                System.debug(newEmails);
            }
            
        }
        return newEmails;
        
       
}
             }