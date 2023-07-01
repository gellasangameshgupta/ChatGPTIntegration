public class SharinPixImageHandler {
    public static void getUrl(List<sharinpix__SharinPixImage__c> si){
        Set<id> ids = new Set<id>();
        set<id> idSp = new set<id>();
        System.debug('enter image url handler');
        for(sharinpix__SharinPixImage__c sc : si){
            ids.add(sc.Work_Order_Line_Item__c);
            idSp.add(sc.Id);
        }
       // List<workorder> workOrder1 = [select id from workorder];
       // List<case> wol =  [select id, workordernumber from workorder];
        
        Map<id,sharinpix__SharinPixImage__c> mapsc = new  Map<id,sharinpix__SharinPixImage__c>();
        List<sharinpix__SharinPixImage__c> sc = [select id, sharinpix__ImageURLMini__c,Work_Order_Line_Item__c ,
                                                 sharinpix__Tags__c ,sharinpix__Title__c,sharinpix__DisplayTags__c
                                                 from sharinpix__SharinPixImage__c where id in : idSp];
        System.debug('sharinpix__SharinPixImage__c'+sc);
        for(sharinpix__SharinPixImage__c sci : sc){
            mapsc.put(sci.Work_Order_Line_Item__c, sci);
        }
        //List<WorkOrderLineItem> workOrderList = new List<SObject>();//
        List<WorkOrderLineItem> wolnToUpdate = new  List<WorkOrderLineItem>();
        List<WorkOrderLineItem> woln = [SELECT id,Before_Image__c, Status,During_Images__c,After_Images__c FROM WorkOrderLineItem where id in :ids];
        System.debug('WorkOrderLineItem'+woln);
        // Map<id, WorkOrder> wolist = new map<id, WorkOrder>(workOrderList);
        for(WorkOrderLineItem wl : woln){
            String url = mapsc.get(wl.Id).sharinpix__ImageURLMini__c;
            System.debug('url'+mapsc.get(wl.Id).sharinpix__ImageURLMini__c);
            System.debug('tag'+mapsc.get(wl.Id).sharinpix__Tags__c);
            System.debug('tag'+mapsc.get(wl.Id).sharinpix__DisplayTags__c);
            //   wl.Before_Image__c =  wl.Before_Image__c + mapsc.get(wl.Id).sharinpix__ImageURLMini__c;
            if(mapsc.get(wl.Id).sharinpix__DisplayTags__c == 'Before'){
                if(wl.Before_Image__c == null){
                    wl.Before_Image__c = '<img src="'+ mapsc.get(wl.Id).sharinpix__ImageURLMini__c+'" width="100" height="100">'+'</img><br/>';
                }
                else{
                    wl.Before_Image__c +='<img src="'+ mapsc.get(wl.Id).sharinpix__ImageURLMini__c+'" width="100" height="100">'+'</img><br/>';
                }
            }
            if(mapsc.get(wl.Id).sharinpix__DisplayTags__c == 'During'){
                if( wl.During_Images__c == null){
                    wl.During_Images__c = '<img src="'+ mapsc.get(wl.Id).sharinpix__ImageURLMini__c+'" width="100" height="100">'+'</img><br/>';
                }
                else{
                    wl.During_Images__c += '<img src="'+ mapsc.get(wl.Id).sharinpix__ImageURLMini__c+'" width="100" height="100">'+'</img><br/>';
                }
                
            }
            if(mapsc.get(wl.Id).sharinpix__DisplayTags__c == 'After'){
                if(wl.After_Images__c == null){
                    wl.After_Images__c = '<img src="'+ mapsc.get(wl.Id).sharinpix__ImageURLMini__c+'" width="100" height="100">'+'</img><br/>';
                }
                else{
                    wl.After_Images__c += '<img src="'+ mapsc.get(wl.Id).sharinpix__ImageURLMini__c+'" width="100" height="100">'+'</img><br/>';
                }
            }
            wolnToUpdate.add(wl);
        }
        if(wolnToUpdate.size() > 0){
            update wolnToUpdate;
        }
    }
}