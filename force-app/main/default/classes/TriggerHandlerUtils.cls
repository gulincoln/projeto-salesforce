public class TriggerHandlerUtils {
    private static boolean run = true;
    public static boolean runOnce(){
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }
    }
    public static boolean shouldRunTrigger(){
        if(!system.isBatch() && !system.isFuture()){
            return true;    
        } 
        return false;
    }
}