/**
* @File Name : GetPropertyData.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : November 6, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | November 6, 2024 |   | Initial Version
**/

public class GetPropertyData {

	@AuraEnabled(cacheable=true)
	Public static List<Property__c>  LightningStudio(){
		 return [Select  Id, Address__c,Image__c, Name , Price__c, Total_Rooms__c from Property__c];
	}
}