public class VFLWCTEST {
    
    @AuraEnabled
    public static String NameData{get; set;}
    
	public static Pagereference downloadPdf(){
        String pageURL = '/apex/vfPage';
        Pagereference downloadPDFPage = new Pagereference(pageURL);
        downloadPDFPage.getHeaders().put('content-disposition','attachment; filename=downloadPDFpage.pdf');
        return downloadPDFPage;	
    }
    
    @AuraEnabled
    public static void lwcMethod(String Name){
        NameData = Name;
        downloadPdf();
    }
}