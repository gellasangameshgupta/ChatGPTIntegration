public class JSON2ApexChatCompletionChatGPT {
    public String id;
    public Integer created;    
    public String model;    
    public cls_usage usage;
    public cls_choices[] choices;
    
    public class cls_usage {
        public Integer prompt_tokens;
        public Integer completion_tokens;    
        public Integer total_tokens;    
    }
    
    public class cls_choices {
        public cls_message message;
        public String finish_reason;    
        public Integer index;
    }
    
    public class cls_message {
        public String role;    
        public String content;    
    }
}