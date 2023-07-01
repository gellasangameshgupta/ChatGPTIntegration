public class ContentVersionHandler {
    
     public static void createPublicLinkForFile(List<ContentVersion> contentVersions){
        Set<Id> contentDocumentIds = new Set<Id>();
        Map<Id,ContentVersion> mapcdcv = new Map<id, ContentVersion>();
        Map<id,id> linkedIdwithCdIds = new Map<id,Id>();

       	for(ContentVersion objContentVersion : contentVersions){
            //if image uploaded then only create public link
            if(objContentVersion.FileType.toLowerCase()=='jpg'){
                system.debug('objContentVersion.FileExtension.toLowerCase():' + objContentVersion.FileType);
                contentDocumentIds.add(objContentVersion.ContentDocumentId);
            //    mapcdcv.put(objContentVersion.ContentDocumentId, objContentVersion);
                
            }
        }
        System.debug('contentDocumentIds'+contentDocumentIds.size());
        Set<id> cdlinkIds = new set<id>();
        Set<id> wolnIds = new set<id>();
        List<ContentDocumentLink> cdList = [select id,LinkedEntityId,ContentDocumentId from ContentDocumentLink where ContentDocumentId in :contentDocumentIds];
        System.debug('cdList'+cdList);
         for(ContentDocumentLink csLink : cdList){
             Schema.SObjectType sobjectType = csLink.LinkedEntityId.getSObjectType();
             if(sobjectType.getDescribe().getName() == 'WorkOrderLineItem'){
                 wolnIds.add(csLink.LinkedEntityId);
                 cdlinkIds.add(csLink.Id);    
                 linkedIdwithCdIds.put(csLink.LinkedEntityId, csLink.ContentDocumentId);
             }
         }
         List<ContentVersion> contentVersionL = [select id, ContentDocumentId,Title,PathOnClient, ContentUrl, FileType from  ContentVersion where ContentDocumentId in: contentDocumentIds];
         system.debug('ContentVersion'+contentVersionL);
         List<ContentDistribution> cdl = new List<ContentDistribution>();
         for(ContentVersion cv : contentVersionL){
             mapcdcv.put(cv.ContentDocumentId, cv);
             ContentDistribution cd = new ContentDistribution();
             cd.ContentVersionId = cv.Id;
             cd.Name = cv.Title;
             cdl.add(cd);
         }
         if(cdl.size() > 0){
             insert cdl;
         }
         map<id,ContentDistribution> mapCdWithCv = new map<id,ContentDistribution>();
         List<ContentDistribution> cd = [select Name,ContentDownloadUrl,DistributionPublicUrl,ContentDocumentId,ContentVersionId from ContentDistribution where ContentDocumentId in: contentDocumentIds];
         for(ContentDistribution cds : cd){
             mapCdWithCv.put(cds.ContentDocumentId, cds);
         }
         system.debug('mapcdcv'+mapcdcv.values());
         system.debug('linkedIdwithCdIds'+linkedIdwithCdIds.values());
         List<WorkOrderLineItem> wolnToUpdate = new List<WorkOrderLineItem>();
         List<WorkOrderLineItem> woln = [select id, Before_Image__c,image_url__c from WorkOrderLineItem where id in :wolnIds];
         for(WorkOrderLineItem wolns : woln){
             Id cdId = linkedIdwithCdIds.get(wolns.Id);
             System.debug('contentDocument Id:'+ cdId);
             ContentDistribution url = mapCdWithCv.get(cdId);
             System.debug('publicurl:'+url.DistributionPublicUrl);
          //   System.debug('url :'+cvurl);
             wolns.Before_Image__c = wolns.Before_Image__c + url.ContentDownloadUrl;
             wolnToUpdate.add(wolns);
         }
         system.debug('wolnToUpdate'+wolnToUpdate);
         if(wolnToUpdate.size() > 0){
             update wolnToUpdate;
         }
    }

}