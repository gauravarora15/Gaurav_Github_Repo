/********************************************************************************************************
* @author         Gaurav
* @description    An SendAutoSurveyWithApexBatch to automate survey sending process.
* @date           03/17/2019
* 
* Modification Log:
* -------------------------------------------------------------------------------------------------------
* Developer                Date                   Modification ID      Description
* -------------------------------------------------------------------------------------------------------
* Gaurav               03/17/2019                                   Initial version
*********************************************************************************************************/
global class SendAutoSurveyWithApexBatch implements Database.Batchable<sObject>{
    
    /********************************************************************************************************
    * @author           Gaurav
    * @date             03/17/2019
    * @description      Batch Class constructor.
    * @param            
    * @return        
    *********************************************************************************************************/
    global SendAutoSurveyWithApexBatch(){
        
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
    * @description      This method sends the survey email to contacts where 
    * @param            conList (List): is the List of Contacts for which surveys needs to be sent.
    *                   BC (Database.BatchableContext)
    * @return        
    *********************************************************************************************************/
    global void execute(Database.BatchableContext BC, List<Contact> conList){
        List<Messaging.SingleEmailMessage> singleMessages = new List<Messaging.SingleEmailMessage>();
        Map<String,EmailTemplate> templateMap = new Map<String,EmailTemplate>();
        try{
            //FETCHING EMAIL TEMPLATE FOR GERMAN AND ENGLISH
            for(EmailTemplate eachTemplate : [Select Id,DeveloperName from EmailTemplate where DeveloperName IN ('English_Survey_Template','German_Survey_Template')])
                templateMap.put(eachTemplate.DeveloperName, eachTemplate);
            //CREATING SINGLE EMAIL MESSAGE FOR ALL THE CONTACTS HAVING SURVEY DATE <= TODAY
            for(Contact eachContact : conList){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                mail.setTargetObjectId(eachContact.Id); 
                mail.setSenderDisplayName(Label.N26_Bank); 
                mail.setUseSignature(false);
                mail.setBccSender(false); 
                mail.setSaveAsActivity(false);
                //SELECTING THE GERMAN OR ENGLISH EMAIL TEMPLATE BASED ON CONTACT LANGUAGE
                if(Label.German_Language_Code.equals(eachContact.Language__c))
                    mail.setTemplateId(templateMap.get(Label.German_Survey_Template).Id);
                else
                    mail.setTemplateId(templateMap.get(Label.English_Survey_Template).Id);
                singleMessages.add(mail);
                eachContact.Survey_Date__c = null;
            }
            /*
             * THIS WILL THROW THE EXCEPTION IF TOTAL EMAILS NEEDED TO BE SENT IN ONE BATCH 
			 * EXCEEDS THE NUMBER OF DAILY EMAIL LIMIT AND THE SURVEY DATE WILL NOT BECOME NULL
			 * AS IT GOES TO CATCH BLOCK AND WILL NOT UPDATE THE CONTACT. THE JOB WILL TRY AGAIN 
			 * NEXT DAY FOR THESE FAILED CONTACT SURVEYS
			 */
            Messaging.reserveSingleEmailCapacity(singleMessages.size());
            Messaging.SendEmailResult[] emailResult = Messaging.sendEmail(singleMessages);
            update conList;
        }
        catch(Exception Ex){
            System.debug(ex.getMessage());
        }
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