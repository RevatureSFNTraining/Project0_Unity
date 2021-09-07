///////////////////////////////////////////////////////////////
//
// Name: FlightCrewtTriggerHandler
// Author: Jordan Gaten, Team Synergy
// Created: 08/30/21
// Updated: 08/31/21
// Description: Handler for AirportTrigger.
//
///////////////////////////////////////////////////////////////
public class FlightCrewTriggerHandler{ 
    public static List<Flight_Crew__c> firstpilotMap(List<Flight_Crew__c> pilotMap) {
        
        // For loop that defines p as the results of the query
        
		 for (List<Flight_Crew__c> p : [SELECT Flight_Crew__c FROM Flight_Crew__c 
                                  WHERE Flight_Crew__c like 'Pilot' LIMIT 1]) {
                                      
            Integer Flightnum = 0;
                 if (Flightnum != 1000000) {
                     insert p;
           
             
                 // puts the flight number and pilot in the pilotList map
             
                 
                
                             } 
    }
        return pilotMap;
                                  }
        
    }