/* Name: uploadImageCntrl 
   Description:  Upload files and show image in richtext field on object record page.
   Created By: Aman Kumar
*/
public with sharing class uploadImageCntrl {

    public transient Blob imageFile{get;set;}
    public string parentRecId ='';
    public void uploadImageCntrl(){
        
    }
     public PageReference uploadImg() {
        parentRecId = ApexPages.currentPage().getParameters().get('id');
        system.debug('record id: ' +parentRecId );
        //ContentVersion
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
        conVer.Title = 'Test File'; 
        conVer.PathOnClient = 'Test File';
        conVer.VersionData = imageFile; // 
        
        insert conVer;
        
        ContentVersion cv = [select id,ContentDocumentId from ContentVersion where id =: conVer.id];
        //Create ContentDocumentLink
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = cv.contentDocumentId;
        cDe.LinkedEntityId = parentRecId; // you can use objectId,GroupId etc
        cDe.ShareType = 'V'; // Inferred permission, checkout description of ContentDocumentLink object for more details
        //Insert content document link
        insert cDe ;
        
        //ContentDistribution: Represents information about sharing a document externally
        ContentDistribution cd = new ContentDistribution();
        cd.Name = 'Test File';
        cd.ContentVersionId  = conVer.Id;
        
        //insert 
        insert cd;
        
        ContentDistribution distribution = [select Name,ContentDownloadUrl from ContentDistribution where id=: cd.id];
        
        WorkOrderLineItem acc = [select id,Before_Image__c from WorkOrderLineItem where id=: parentRecId]; //ARI__Images__c (ARI__ is Namspace. it will be different in your case) 
        if(acc.Before_Image__c == null){
            acc.Before_Image__c ='';
        }
        acc.Before_Image__c += '<img src="'+distribution.ContentDownloadUrl+'" width="80" height="100">'+'</img><br/>'; 
        
        update acc;
        
        return null;
    }

}