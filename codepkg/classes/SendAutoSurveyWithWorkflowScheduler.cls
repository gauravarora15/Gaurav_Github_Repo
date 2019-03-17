/********************************************************************************************************
* @author         Gaurav
* @description    SendAutoSurveyWithWorkflowScheduler class is created for scheduling 
*				  SendAutoSurveyWithWorkflowBatch class
* @date           03/17/2019
* 
* Modification Log:
* -------------------------------------------------------------------------------------------------------
* Developer                Date                   Modification ID      Description
* -------------------------------------------------------------------------------------------------------
* Gaurav               03/17/2019                                   Initial version
*********************************************************************************************************/
global class SendAutoSurveyWithWorkflowScheduler implements Schedulable{
    
    /********************************************************************************************************
    * @author           Gaurav
    * @date             03/17/2018
    * @description      This Method is triggered automatically and will execute the batch.
    * @param            sc (SchedulableContext)
    * @return        
    *********************************************************************************************************/
    global void execute(SchedulableContext sc) {
        //EXECUTING THE BATCH CLASS
        SendAutoSurveyWithWorkflowBatch b = new SendAutoSurveyWithWorkflowBatch();
        Database.executebatch(b,200);
    }
}