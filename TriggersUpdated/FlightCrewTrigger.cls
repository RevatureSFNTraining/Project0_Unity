///////////////////////////////////////////////////////////////
//
// Name: FlightCrewTrigger
// Author: Jordan Gaten, Team Synergy
// Created: 08/29/21
// Updated: 08/31/21
// Description: Trigger that assigns a pilot a flight number
//
///////////////////////////////////////////////////////////////
trigger FlightCrewTriggerp on Flight_Crew__c (before insert, before update, Before delete, after delete, after undelete, after update, after insert) {
    switch on Trigger.operationType{
        
        when BEFORE_INSERT{
            FlightCrewTriggerHandler.Firstpilotmap(trigger.new);
           
        }
        when BEFORE_UPDATE{
            
        }
        When BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
            
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
	
}