package model;

public class Post {

    String id;
    String userId;
    String content;
    String image;
    String dateTime;
    String totalLikes;
    String postedBy;
    String postedByPic;
    String likedByMe;

    public String getLikedByMe() {
        return likedByMe;
    }

    public void setLikedByMe(String likedByMe) {
        this.likedByMe = likedByMe;
    }

    public String getPostedBy() {
        return postedBy;
    }

    public void setPostedBy(String postedBy) {
        this.postedBy = postedBy;
    }

    public Post() {

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getTotalLikes() {
        return totalLikes;
    }

    public void setTotalLikes(String totalLikes) {
        this.totalLikes = totalLikes;
    }

    @Override
    public String toString() {
        return "Post{" +
                "id='" + getId() + '\'' +
                ", userId='" + getUserId() + '\'' +
                ", content='" + getContent() + '\'' +
                ", images='" + getImage() + '\'' +
                ", dateTime='" + getDateTime() + '\'' +
                ", totalLikes='" + getTotalLikes() + '\'' +
                ", postedBy='" + getPostedBy() + '\'' +
                ", likedByMe='" + getLikedByMe() + '\'' +
                '}';
    }

    public String getPostedByPic() {
        return postedByPic;
    }

    public void setPostedByPic(String postedByPic) {
        this.postedByPic = postedByPic;
    }

}
