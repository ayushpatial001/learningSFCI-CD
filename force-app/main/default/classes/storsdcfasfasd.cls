/**
* @File Name : storsdcfasfasd.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 23, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 23, 2024 |   | Initial Version
**/
public with sharing class storsdcfasfasd {
   @AuraEnabled
    public static String generatePdf(String name) { 
       PageReference pageRef = Page.vfPage;
        pageRef.getParameters().put('name', name);
        Blob pdfBlob = pageRef.getContentAsPDF();
        
        String base64Pdf = EncodingUtil.base64Encode(pdfBlob);
        return base64Pdf;
    }
}