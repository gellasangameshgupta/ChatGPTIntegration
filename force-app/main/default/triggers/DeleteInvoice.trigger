trigger DeleteInvoice on Invoice__c (before delete) {
    
    if(Trigger.isBefore && Trigger.isDelete)
    {
        InvoiceTriggerHandler.invoiceDetailedError(Trigger.old);
    }

}