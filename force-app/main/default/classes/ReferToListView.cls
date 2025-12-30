public class ReferToListView {
    // variable contact type
    public final Contact con ;
    
    // const 
    public ReferToListView(ApexPages.StandardController sc){
        
        this.con = (Contact)sc.getRecord();
        
    }
    
    public PageReference makeFunction(){
        
            insert con;
            PageReference pageRef = new PageReference('/lightning/o/Contact/list');
            pageRef.setRedirect(true);
            return pageRef;
            
       
        
    }
    
}