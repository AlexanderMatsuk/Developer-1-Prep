trigger HelloWorldTrigger2 on Account (before insert) {
    for (Account acc : Trigger.New){
        if (acc.Name == 'ERROR Account'){
            acc.addError('This Account can not be added!');
        }
    }

}