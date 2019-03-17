/********************************************************************************************************
* @author         Gaurav
* @description    An SendAutoSurveyWithWorkflowBatch to automate survey sending process 
* @date           03/17/2019
* 
* Modification Log:
* -------------------------------------------------------------------------------------------------------
* Developer                Date                   Modification ID      Description
* -------------------------------------------------------------------------------------------------------
* Gaurav               03/17/2019                                   Initial version
*********************************************************************************************************/
global class SendAutoSurveyWithWorkflowBatch implements Database.Batchable<sObject>{
    
    /********************************************************************************************************
    * @author           Gaurav
    * @date             03/17/2019
    * @description      Batch Class constructor.
    * @param            
    * @return        
    *********************************************************************************************************/
    global SendAutoSurveyWithWorkflowBatch(){
        
    }
    
    /********************************************************************************************************
    * @author           Gaurav
    * @date             03/17/2019
    * @description      Satrt Method of Batch Class used to get query
    * @param            BC (Database.BatchableContext)
    * @return           Database.QueryLocator
    *********************************************************************************************************/
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(Label.Contact_Survey_Query);
    }
    
    /********************************************************************************************************
    * @author           Gaurav
    * @date             03/17/2019
    * @description      This method update the send survey field which in turn call invoke workflow for 
    * 					sending mail
    * @param            conList (List): is the List of Contacts for which surveys needs to be sent
    *                   BC (Database.BatchableContext)
    * @return        
    *********************************************************************************************************/
    global void execute(Database.BatchableContext BC, List<Contact> conList){
        for(Contact eachContact : conList){
            eachContact.Survey_Date__c = null;
            eachContact.Send_Survey__c = true;
        }
        update conList;
    }
    
    /********************************************************************************************************
    * @author           Gaurav
    * @date             03/17/2019
    * @description      Final Method of Batch for some processing after execute method.
    * @param            BC (Database.BatchableContext)
    * @return        
    *********************************************************************************************************/
    global void finish(Database.BatchableContext BC){
        
    }
}