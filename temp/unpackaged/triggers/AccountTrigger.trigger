trigger AccountTrigger on Account (after insert, after update) {
    TriggerDispatcher.Run(new AccountTriggerHandler());
}