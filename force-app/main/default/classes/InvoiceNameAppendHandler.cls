public class InvoiceNameAppendHandler {
    
    public static void nameUpdate(List<invoice__c> invoiceList)
    {
        for(Invoice__c invoiceRecord :invoiceList )
        {
            invoiceRecord.Name__c = invoiceRecord.Name__c + 'Absyz';
            invoiceList.add(invoiceRecord);
        }
        if(invoiceList.size() > 0)
        {
            update invoiceList;
        }
    }

}