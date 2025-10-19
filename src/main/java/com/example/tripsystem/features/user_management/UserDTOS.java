package com.example.tripsystem.features.user_management;

public class UserDTOS {

    public static class CreateUserRequest {
        private String firstName;
        private String lastName;
        private String email;
        private String phoneNumber;
        private String country;
        private String vehicleType;
        private String password;
        private UserModel.UserRole userRole;
        private String language;
        private String expertise;

        public CreateUserRequest() {}

        public CreateUserRequest(String firstName, String lastName, String email, String phoneNumber, String country, String vehicleType, String password, UserModel.UserRole userRole) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.phoneNumber = phoneNumber;
            this.country = country;
            this.vehicleType = vehicleType;
            this.password = password;
            this.userRole = userRole;
        }

        public String getFirstName() { return firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getLastName() { return lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPhoneNumber() { return phoneNumber; }
        public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
        public String getCountry() { return country; }
        public void setCountry(String country) { this.country = country; }
        public String getVehicleType() { return vehicleType; }
        public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        public UserModel.UserRole getUserRole() { return userRole; }
        public void setUserRole(UserModel.UserRole userRole) { this.userRole = userRole; }
        public String getLanguage() { return language; }
        public void setLanguage(String language) { this.language = language; }
        public String getExpertise() { return expertise; }
        public void setExpertise(String expertise) { this.expertise = expertise; }
    }

    public static class UpdateUserRequest {
        private String firstName;
        private String lastName;
        private String email;
        private String phoneNumber;
        private String country;
        private String vehicleType;
        private UserModel.UserRole userRole;
        private String language;
        private String expertise;

        public UpdateUserRequest() {}

        public UpdateUserRequest(String firstName, String lastName, String email, String phoneNumber, String country, String vehicleType, UserModel.UserRole userRole) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.phoneNumber = phoneNumber;
            this.country = country;
            this.vehicleType = vehicleType;
            this.userRole = userRole;
        }

        public String getFirstName() { return firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getLastName() { return lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPhoneNumber() { return phoneNumber; }
        public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
        public String getCountry() { return country; }
        public void setCountry(String country) { this.country = country; }
        public String getVehicleType() { return vehicleType; }
        public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
        public UserModel.UserRole getUserRole() { return userRole; }
        public void setUserRole(UserModel.UserRole userRole) { this.userRole = userRole; }
        public String getLanguage() { return language; }
        public void setLanguage(String language) { this.language = language; }
        public String getExpertise() { return expertise; }
        public void setExpertise(String expertise) { this.expertise = expertise; }
    }

    public static class LoginRequest {
        private String email;
        private String password;

        public LoginRequest() {}

        public LoginRequest(String email, String password) {
            this.email = email;
            this.password = password;
        }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }

    public static class UserResponse {
        private Long id;
        private String firstName;
        private String lastName;
        private String email;
        private String phoneNumber;
        private String country;
        private String vehicleType;
        private UserModel.UserRole userRole;
        private String language;
        private String expertise;

        public UserResponse() {}

        public UserResponse(Long id, String firstName, String lastName, String email, String phoneNumber, String country, String vehicleType, UserModel.UserRole userRole) {
            this.id = id;
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.phoneNumber = phoneNumber;
            this.country = country;
            this.vehicleType = vehicleType;
            this.userRole = userRole;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public String getFirstName() { return firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getLastName() { return lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPhoneNumber() { return phoneNumber; }
        public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
        public String getCountry() { return country; }
        public void setCountry(String country) { this.country = country; }
        public String getVehicleType() { return vehicleType; }
        public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
        public UserModel.UserRole getUserRole() { return userRole; }
        public void setUserRole(UserModel.UserRole userRole) { this.userRole = userRole; }
        public String getLanguage() { return language; }
        public void setLanguage(String language) { this.language = language; }
        public String getExpertise() { return expertise; }
        public void setExpertise(String expertise) { this.expertise = expertise; }
    }
}