/********************************************************************************************************
* @author         Gaurav
* @description    This calss is created for ProductInfoPage Lightning Component
* @date           03/17/2019
* 
* Modification Log:
* -------------------------------------------------------------------------------------------------------
* Developer                Date                   Modification ID      Description
* -------------------------------------------------------------------------------------------------------
* Gaurav               03/17/2019                                   Initial version
*********************************************************************************************************/
public class ProductInfoCtrl {
    /********************************************************************************************************
    * @author           Gaurav
    * @date             03/17/2019
    * @description      This methods gets the case Id and return all the product cost data stored in the 
    * 					custom settings
    * @param            recordId (Id): Id of the Case for which details are required.
    * @return        	ProductWrapper - return all product details from custom settings
    *********************************************************************************************************/
    @AuraEnabled
    public static ProductWrapper getProductsData(String recordId){
        ProductWrapper prodWrap = new ProductWrapper();
        try{
            //FETCHING THE CASE RECORD
            Case newCase = [SELECT Id,Contact.Product__r.Name,Contact.Country__c FROM Case WHERE Id =: recordId];
            
            //FETCHING ALL 3 CUSTOM SETTINGS FOR DIFFERENT DATA OF PRODUCT BASED ON CONTACT HOME COUNTRY
            List<CostPerCalendarMonth__c> costPerMonth = [SELECT Id, Country__c, Price__c, Product__c FROM CostPerCalendarMonth__c WHERE Country__c =: newCase.Contact.Country__c AND Product__c =: newCase.Contact.Product__r.Name];
            List<ATMFeeInOtherCurrencies__c> atmFee = [SELECT Id, Country__c, Price__c, Product__c FROM ATMFeeInOtherCurrencies__c WHERE Country__c =: newCase.Contact.Country__c AND Product__c =: newCase.Contact.Product__r.Name];
            List<CardReplacementCost__c> cardReplacementCost = [SELECT Id, Country__c, Price__c, Product__c FROM CardReplacementCost__c WHERE Country__c =: newCase.Contact.Country__c AND Product__c =: newCase.Contact.Product__r.Name];
            
            //PASSING THE DATA TO WRAPPER RECORD FROM CUSTOM SETTINGS
            if(!costPerMonth.isEmpty())
                prodWrap.costPerMonth = costPerMonth[0].Price__c;
            if(!atmFee.isEmpty())
                prodWrap.atmFee = atmFee[0].Price__c;
            if(!cardReplacementCost.isEmpty())
                prodWrap.cardReplacementCost = cardReplacementCost[0].Price__c;
            prodWrap.country = newCase.Contact.Country__c;
            prodWrap.product = newCase.Contact.Product__r.Name;
        }
        catch(Exception ex){
            system.debug(ex.getMessage());
        }
        return prodWrap;
    }
    /**********************************Wrapper Class****************************************/
    public class ProductWrapper{
        @AuraEnabled
        public String costPerMonth;
        @AuraEnabled
        public String atmFee;
        @AuraEnabled
        public String cardReplacementCost;
        @AuraEnabled
        public String country;
        @AuraEnabled
        public String product;
        //Contructor
        public ProductWrapper(){
            costPerMonth = '';
            atmFee = '';
            cardReplacementCost = '';
        }
    }
}