trigger ContentVersionTrigger on ContentVersion (before insert, after insert) {
     if(trigger.isafter && trigger.isinsert){
        ContentVersionHandler.createPublicLinkForFile(trigger.new);
    }

}