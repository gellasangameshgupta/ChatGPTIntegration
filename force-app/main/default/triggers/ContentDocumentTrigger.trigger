trigger ContentDocumentTrigger on ContentDocument (before insert, After Insert) {
    if(trigger.isafter && trigger.isinsert){
    //    ContentDocumentHandler.createPublicLinkForFile(trigger.new);
    }
}