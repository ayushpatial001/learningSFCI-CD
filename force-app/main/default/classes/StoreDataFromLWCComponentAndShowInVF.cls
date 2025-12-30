/**
* @File Name : StoreDataFromLWCComponentAndShowInVF.cls
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

public class StoreDataFromLWCComponentAndShowInVF {
    @AuraEnabled
	public static String NameD{get; set;}

	public StoreDataFromLWCComponentAndShowInVF(){
         System.debug('This is the scenario of these case ');
		
    }
    
	

	public static Pagereference downloadPdf(){
		System.debug('This is the page that we want to download');
        String pageURL = 'https://techmatrixconsulting112-dev-ed--c.develop.vf.force.com/apex/CallVFPageFromLWC';
        
        Pagereference downloadPDFPage = new Pagereference(pageURL);
        downloadPDFPage.getHeaders().put('content-disposition','attachment; filename=downloadPDFpage.pdf');
        System.debug('PagerRefernece'+ downloadPDFPage);
        return downloadPDFPage;	
        
        
    }
	
	@AuraEnabled
	Public static void LightningStudio(String Name){
		 NameD = Name;
		 System.debug('This is the Name-->'+ NameD);
		 downloadPdf();
	}
}