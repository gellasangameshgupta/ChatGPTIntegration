public class InvoiceStatusHandler {
    
    public static void deleteInvoice(List<Invoice__c> invoiceList)
    {
        for(Invoice__c invoiceRecord :invoiceList)
        {
            if(invoiceRecord.Status__c == 'closed')
            {
                
                invoiceRecord.addError('Ypu cannot delete an Invoice when Status is Closed ');
            }
        }
    }

}