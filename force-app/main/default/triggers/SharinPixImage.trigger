trigger SharinPixImage on sharinpix__SharinPixImage__c (after insert) {
    SharinPixImageHandler.getUrl(trigger.new);
}