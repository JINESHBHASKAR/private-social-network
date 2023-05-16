
package model;


public class Message {
    
    String id;
    String message;
    String dateTime;
    String sentBy;
    String sentByProfilePic;
    String receiveBy;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getSentBy() {
        return sentBy;
    }

    public void setSentBy(String sentBy) {
        this.sentBy = sentBy;
    }

    public String getReceiveBy() {
        return receiveBy;
    }

    public void setReceiveBy(String receiveBy) {
        this.receiveBy = receiveBy;
    }

    public String getSentByProfilePic() {
        return sentByProfilePic;
    }

    public void setSentByProfilePic(String sentByProfilePic) {
        this.sentByProfilePic = sentByProfilePic;
    }
    
}
