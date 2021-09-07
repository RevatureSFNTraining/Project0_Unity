///////////////////////////////////////////////////////////////
//
// Name: emailTrigger
// Author: Jordan Gaten, Team Synergy
// Created: 08/29/21
// Updated: 08/31/21
// Description: Trigger that confirms that the payment amount provided matches the ticket price.
//
///////////////////////////////////////////////////////////////
trigger emailTrigger on Passanger_Accounts__c (before insert, before update, Before delete, after delete, after undelete, after update, after insert) {
    switch on trigger.operationType{
        
        when BEFORE_INSERT{
            emailTriggerHandler.FlightSet(trigger.new);
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