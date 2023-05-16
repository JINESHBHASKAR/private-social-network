package model;

public class User {

    String id;
    String fullName;
    String gender;
    String profilePic;
    String state;
    String city;
    String street;
    String pinCode;
    String birthYear;
    String email;
    String password;

    public User() {
    }

    public User(String id, String fullName, String gender, String profilePic, String state, String city, String street, String pinCode, String birthYear, String email, String password) {
        this.id = id;
        this.fullName = fullName;
        this.gender = gender;
        this.profilePic = profilePic;
        this.state = state;
        this.city = city;
        this.street = street;
        this.pinCode = pinCode;
        this.birthYear = birthYear;
        this.email = email;
        this.password = password;
    }
    
        public User(String id, String fullName, String gender, String profilePic, String state, String city, String street, String pinCode, String birthYear) {
        this.id = id;
        this.fullName = fullName;
        this.gender = gender;
        this.profilePic = profilePic;
        this.state = state;
        this.city = city;
        this.street = street;
        this.pinCode = pinCode;
        this.birthYear = birthYear;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getPinCode() {
        return pinCode;
    }

    public void setPinCode(String pinCode) {
        this.pinCode = pinCode;
    }

    public String getBirthYear() {
        return birthYear;
    }

    public void setBirthYear(String birthYear) {
        this.birthYear = birthYear;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return this.getStreet() + ", " + this.getCity() + ", " + this.getState() + " - " + this.getPinCode();
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }
}
