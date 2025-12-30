public class DownlodPaySlip {
    
    
    public Pagereference downloadPdf(){
        String pageURL = '/apex/MonthlySalaryPdf';
        
        Pagereference downloadPDFPage = new Pagereference(pageURL);
        downloadPDFPage.getHeaders().put('content-disposition','attachment; filename=downloadPDFpage.pdf');
        
        return downloadPDFPage;	
        
        
    }
    
    public DownlodPaySlip(ApexPages.StandardController controller){
          downloadPdf();
    }
    
    

}