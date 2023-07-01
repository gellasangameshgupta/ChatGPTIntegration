public with sharing class EinsteinChatBotController {
    
     public class OrderOutput {
    @InvocableVariable(required=true)
    public String sProductName;
  }
 
  public class OrderInput {
    @InvocableVariable(required=true)
    public String sProductCategory;
  }
 
  @InvocableMethod(label='Get Product Details')
  public static List<OrderOutput> getProductDetails(List<OrderInput> orderInputs) {
      System.debug('method is invoked');
    Set<String> productCategory = new Set<String>(); 
 
    // Get the product category from the input
    for (OrderInput orderInput : orderInputs) {
      productCategory.add(orderInput.sProductCategory);
    }
 
    // Get the order objects from the set of product category
    List<AK_Electronic__c> orders = 
      [SELECT Name,Model_Name__c,Category__c FROM AK_Electronic__c where Category__c in : productCategory];
      
    // Create a map of product category and product name values
    Map<String, String> mapCategoryName = new Map<String, String>(); 
    if (orders.size() > 0) {
        for (AK_Electronic__c order : orders) {
          mapCategoryName.put(order.Category__c, order.Model_Name__c);
        }
    }
    
    // Build a list of order status values for the output
    List<OrderOutput> orderOutputs = new List<OrderOutput>();
    for (OrderInput orderInput : orderInputs) {
      OrderOutput orderOutput = new OrderOutput();
      
      // Do we have a product for this category?
      if (mapCategoryName.containsKey(orderInput.sProductCategory)) {
          // If so, then add the status
          orderOutput.sProductName = mapCategoryName.get(orderInput.sProductCategory);
      } else {
          // If not, then add an unknown product value
          orderOutput.sProductName = 'product not found';
      }
      orderOutputs.add(orderOutput);
    }
 
    return orderOutputs;    
  }

}