trigger CountTotalQunatityOnOpportunity on OpportunityLineItem (after insert) {
     // Count Total Quantity of Product in Opportunity LineItem and Show It on That Related Account
     Map<Id, List<OpportunityLineItem>> mapOfProductRelatedToOpportunity = new Map<Id, List<OpportunityLineItem>>();
    Map<Id, List<Opportunity>> mapOfOpportunityRelatedToAccount = new Map<Id,  List<Opportunity>>();
    
}