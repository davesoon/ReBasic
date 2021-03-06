//Logs messages to box & prints to console
class ConsoleLog{
  ArrayList<ConsoleEntry> messages;
  
  ConsoleLog(){
    messages = new ArrayList<ConsoleEntry>();
  }
  
  void render(float x, float y){
    //prints the latest 50 lines
    int start = messages.size() - 50;
    if(start < 0)
      start = 0;
    
    //translates all messages to start at x, y
    pushMatrix();
    translate(x, y);
    textSize(10);
    for(int i = start; i < messages.size(); i ++){
      messages.get(i).render(0, (i - start) * 10);
    }
    popMatrix();
  }
  
  void colorTest(){
    printbar();
    println("123456789012345678901234567890123456789012345678".length());
    warning("warning");
    error("error");
    info("info");
    notif("notif");
  }
  
  //Black message
  void debug(String s){
    messages.add(new ConsoleEntry(s));
    println(s);
  }
  
  //Blank line
  void debug(){
    messages.add(new ConsoleEntry());
    println(); 
  }
  
  //Yellow message
  void warning(String s){
    s = "[WARNING] " + s;
    messages.add(new WarningEntry(s));
    println(s);
  }
  
  //Red message
  void error(String s){
    s = "[ERROR] " + s;
    messages.add(new ErrorEntry(s));
    println(s);
  }
  
  //Blue message
  void info(String s){
    s = "[INFO] " + s;
    messages.add(new InfoEntry(s));
    println(s);
  }
  
  //Green message
  void notif(String s){
    messages.add(new NotifEntry(s));
    println(s);
  }
  
  void printbar(){
    messages.add(new ConsoleEntry("----------------"));
    println("----------------");
  }
}

class ConsoleEntry{
  String message;
  ConsoleEntry(){
    message = "";
  }
  
  ConsoleEntry(String m){
    message = m;
  }
  
  void render(float x, float y){
    fill(colorscheme[0]);
    text(message, x + 4, y);
  }
}

class WarningEntry extends ConsoleEntry{
  WarningEntry(String m){
    message = m;
  }
  
  void render(float x, float y){
    fill(colorscheme[3]);
    text(message, x + 4, y);
  }
}

class ErrorEntry extends ConsoleEntry{
  ErrorEntry(String m){
    message = m;
  }
  
  void render(float x, float y){
    fill(colorscheme[4]);
    text(message, x + 4, y);
  }
}

class InfoEntry extends ConsoleEntry{
  InfoEntry(String m){
    message = m;
    if(message.length() > 47){
      if(message.length() % 47 == 0){
        String newMessage = message.substring(0, message.length() - 47);
        message = message.substring(message.length() - 47);
        log.messages.add(new InfoEntry(newMessage));
      }
      else{
        for(int i = 0; i < 47; i ++){
          if((message.length() - i) % 47 == 0){
            String newMessage = message.substring(0, message.length() - i);
            message = message.substring(message.length() - i);
            log.messages.add(new InfoEntry(newMessage));
            break;
          }
        }
      }
    }
  }
  
  void render(float x, float y){
    fill(colorscheme[5]);
    text(message, x + 4, y);
  }
}

class NotifEntry extends ConsoleEntry{
  NotifEntry(String m){
    message = m;
  }
  
  void render(float x, float y){
    fill(colorscheme[6]);
    text(message, x + 4, y);
  }
}