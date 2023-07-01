trigger AopendName on Invoice__c (before insert) {
    for(Invoice__c invoiceName: Trigger.new)
    {
       invoiceName.Name__c =invoiceName.Name__c +' Absyz';
    }

}