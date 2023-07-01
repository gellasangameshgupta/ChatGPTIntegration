public class InvoiceTriggerHandler {
    public static void invoiceDetailedError(List<invoice__c> listOfInvoice)
    {
        for(Invoice__c inv :listOfInvoice)
        {
            if(inv.status__c =='closed'){
                inv.addError('You cannot delete this Invoice');
            }
        }
    }

}