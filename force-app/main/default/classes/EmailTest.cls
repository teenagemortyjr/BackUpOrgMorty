public class EmailTest{
    //Simple code to send email to a number of email addresses
    public static void sendSimpleEmail(List<String> recipientList, String subject, String emailBody){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(recipientList);
        email.setSubject(subject);
        email.setPlainTextBody(emailBody);
        email.setHtmlBody(emailBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
    /* After saving this class execute below code from developer console
    *  EmailUtility.sendSimpleEmail(new List<String>{'myemail@gmail.com'}, 'Subject Here', 'Body Here');
    */
}