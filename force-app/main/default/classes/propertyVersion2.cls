/**
* @File Name : propertyVersion2.cls
* @Description :
* @Author : Ayush Patial
* @Last Modified By :
* @Last Modified On : November 7, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | November 7, 2024 |   | Initial Version
**/

public class propertyVersion2 {
	@AuraEnabled
	Public static List<Property__c> getData(String recrodData){
		System.debug('this is the data'+ recrodData);
		return [select Id ,Address__c, Image__c ,Name ,Price__c,Total_Rooms__c from Property__c Where Id =:  recrodData];
	}
}