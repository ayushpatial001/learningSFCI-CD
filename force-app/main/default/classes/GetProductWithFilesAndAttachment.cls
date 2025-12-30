public with sharing class GetProductWithFilesAndAttachment {
    @AuraEnabled
    public static List<Product2> listOfProduct(){
         return [SELECT IsActive, Name, Id, Price__c FROM Product2 where IsActive = true AND Price__c != NULL];
    }

    @AuraEnabled
    public static  List<Product2> methodName(String allData){
        return [SELECT IsActive, Name, Id, Price__c, Description FROM Product2 where Id =: allData];
    }
    
    @AuraEnabled
    public static Map<String, Object> getProduct(Integer pageSize, Integer pageNumber) {
        List<Product2> employees = [SELECT IsActive, Name, Id, Price__c FROM 
                                       Product2 where IsActive = true AND Price__c != NULL
                                       ORDER BY CreatedDate DESC
                                       LIMIT :pageSize
                                       OFFSET :((pageNumber - 1) * pageSize)];

        Integer totalEmployees = [SELECT Count() FROM Product2];

        Map<String, Object> result = new Map<String, Object>();
        result.put('records', employees);
        result.put('total', totalEmployees);
        return result;
    }
}











// // imageFromContentDocument.js
// import { LightningElement, wire } from 'lwc';
// import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
// import IMAGE_URL_FIELD from 
//     '@salesforce/schema/ContentDocument.LatestPublishedVersion.VersionDataUrl';

// export default class ImageFromContentDocument extends LightningElement {

//     @wire(getRecord, {recordId: '069RO0000003FMoYAM', fields: [IMAGE_URL_FIELD] })
//     contentDocImage;

//     get imageUrl() {
//         return getFieldValue(this.contentDocImage.data, IMAGE_URL_FIELD);
//     }

//     get resizedImageUrl() {
//         return getFieldValue(this.contentDocImage.data, IMAGE_URL_FIELD) + 
//             '?thumb=THUMB240BY180';
//     }
// }

// <!-- imageFromContentDocument.html -->
// <template>
//     <lightning-card>Display an image from 
//         ContentDocument {imageUrl}</lightning-card>

//     <template if:true={contentDocImage}>
//         <img src={imageUrl}/>
//     </template>

//     <lightning-card>Display a resized image from ContentDocument
//         {resizedImageUrl}</lightning-card>

//     <template if:true={contentDocImage}>
//         <img src={resizedImageUrl}/>
//     </template>

// </template>