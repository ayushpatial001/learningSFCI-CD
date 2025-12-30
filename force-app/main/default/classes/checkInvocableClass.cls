public class checkInvocableClass {
    
    
     @InvocableMethod
    public static void checkMultipleRecords(List<String> multipleRecords){
        System.debug('There are the records' + multipleRecords);
    }

}