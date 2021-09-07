///////////////////////////////////////////////////////////////
//
// Name: SeatSelectTriggerHandler
// Author: Jordan Gaten, Team Synergy
// Created: 08/29/21
// Updated: 08/31/21
// Description: Handler for SeatSelectTrigger.
//
///////////////////////////////////////////////////////////////
public class SeatSelectTriggerHandler{
    public Static List<Plane_Ticket__c> generalSeats(List<Plane_Ticket__c> b) {
       for (List<Plane_Ticket__c> a : [SELECT Seat_Selection__c FROM Plane_Ticket__c 
                                      WHERE Seat_Selection__c = 'General Seat']){ 
                         
                                    // Condition to set limit of general seats
                                        if (20 < a.size()){
                                            
                                          
                                            
        
            // Line defines which record will recieve the error message
            
                         
                                                  }
                         
                       System.debug(b);
        
  

                                              }
        return b;
   }
}