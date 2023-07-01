public with sharing class chatBotQueryMailController {
	
    public class SendEmailParams{
        @InvocableVariable(required=true)
        public String emailId;
        @InvocableVariable(required=true)
        public String issueStateMent;
    }
    
   @InvocableMethod(label='Send Email to Agent')
    public static void sendEmail(SendEmailParams[] params){
        String emailId = '';
        String issueStateMent = '';
        if(!params.isEmpty()){
            emailId = params[0].emailId;
            issueStateMent = params[0].issueStateMent;
        }
        System.debug('emailId:'+emailId);
        System.debug('issueStateMent:'+issueStateMent);
        List<String> toAddresses = Label.AaagentEmail.split(',');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(toAddresses);
        email.setSubject('Query about Product');
        String body = '<html>';
        body += '<b>Hi,</b><br/>';
        body += 'A new query has been assigned to you<br/>';
        body += '<b>User Email:</b> '+emailId+'<br/>';
        body += '<b>Query:</b><br/>';
        body += issueStatement + '<br/>';
        body += '</html>';
        
        email.setHtmlBody(body);
        messaging.sendEmail(new List<Messaging.SingleEmailMessage> {email});
                
    }
    
    
}