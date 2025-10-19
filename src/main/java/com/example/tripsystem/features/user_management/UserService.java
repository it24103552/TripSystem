package com.example.tripsystem.features.user_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public UserDTOS.UserResponse createUser(UserDTOS.CreateUserRequest request) {
        UserModel user = new UserModel(
                request.getFirstName(),
                request.getLastName(),
                request.getEmail(),
                request.getPhoneNumber(),
                request.getCountry(),
                request.getVehicleType(),
                request.getPassword(),
                request.getUserRole()
        );
        user.setLanguage(request.getLanguage());
        user.setExpertise(request.getExpertise());
        UserModel savedUser = userRepository.save(user);
        return convertToUserResponse(savedUser);
    }

    public Optional<UserDTOS.UserResponse> getUserById(Long id) {
        return userRepository.findById(id).map(this::convertToUserResponse);
    }

    public List<UserDTOS.UserResponse> getAllUsers() {
        return userRepository.findAll().stream()
                .map(this::convertToUserResponse)
                .collect(Collectors.toList());
    }

    public Optional<UserDTOS.UserResponse> updateUser(Long id, UserDTOS.UpdateUserRequest request) {
        return userRepository.findById(id).map(user -> {
            user.setFirstName(request.getFirstName());
            user.setLastName(request.getLastName());
            user.setEmail(request.getEmail());
            user.setPhoneNumber(request.getPhoneNumber());
            user.setCountry(request.getCountry());
            user.setVehicleType(request.getVehicleType());
            user.setUserRole(request.getUserRole());
            user.setLanguage(request.getLanguage());
            user.setExpertise(request.getExpertise());
            UserModel updatedUser = userRepository.save(user);
            return convertToUserResponse(updatedUser);
        });
    }

    public boolean deleteUser(Long id) {
        if (userRepository.existsById(id)) {
            userRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public Optional<UserDTOS.UserResponse> login(UserDTOS.LoginRequest request) {
        return userRepository.findByEmailAndPassword(request.getEmail(), request.getPassword())
                .map(this::convertToUserResponse);
    }

    private UserDTOS.UserResponse convertToUserResponse(UserModel user) {
        UserDTOS.UserResponse response = new UserDTOS.UserResponse(
                user.getId(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getPhoneNumber(),
                user.getCountry(),
                user.getVehicleType(),
                user.getUserRole()
        );
        response.setLanguage(user.getLanguage());
        response.setExpertise(user.getExpertise());
        return response;
    }
}