trigger TriggerOnLead on Lead (before insert, before update) {
        Set<String> newEmailSet = new Set<String>();
    Set<String> oldEmailSet = new Set<String>();
    
    for (Lead a: trigger.New) {
        newEmailSet.add(a.Email);
    }
    
    for (Lead b: [Select Email From Lead Where Email IN: newEmailSet]) {
        oldEmailSet.add(b.Email);
    }
    
    for (Lead a: trigger.New) {
        if (oldEmailSet.contains(a.Email)) {
            a.addError('You cannot insert a duplicate record');
        }
    }


}