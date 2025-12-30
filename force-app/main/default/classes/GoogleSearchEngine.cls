/**
* @File Name : GoogleSearchEngine.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : December 9, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | December 9, 2024 |   | Initial Version
**/

public class GoogleSearchEngine {
    
	
    private static final String API_KEY = 'AIzaSyAOT8UM21Xjtwrmkd3QNCUJkIo5XBYr9jc';
	
    private static final String SEARCH_ENGINE_ID = '144399ac747604519';

    public class SearchResult {
		@AuraEnabled
        public String title; 
		@AuraEnabled
        public String link;
		@AuraEnabled
        public String snippet;
    }

    @AuraEnabled
    public static List<SearchResult> SearchingResult(String query) {
        String endpoint = 'https://www.googleapis.com/customsearch/v1?key=' + API_KEY + '&cx=' + SEARCH_ENGINE_ID + '&q=' + EncodingUtil.urlEncode(query, 'UTF-8') ;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        HttpResponse response = http.send(request); 
        List<SearchResult> results = new List<SearchResult>();

        if (response.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('The Response -->' + JSON.serializePretty(responseMap));
            List<Object> items = (List<Object>) responseMap.get('items');
            
            if (items != null) {
                for (Object item : items) {
                    Map<String, Object> itemMap = (Map<String, Object>) item;
                    SearchResult result = new SearchResult();
                    result.title = (String) itemMap.get('title');
                    result.link = (String) itemMap.get('link');
                    result.snippet = (String) itemMap.get('snippet');
                    results.add(result);
                }
            }
        }
        System.debug('The Result -->' + results);
        return results;
    }
}