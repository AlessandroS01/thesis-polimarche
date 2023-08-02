package com.example.polimarche_api.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNAUTHORIZED)
public class LoginUnauthorizedException extends RuntimeException {

    public LoginUnauthorizedException(String message) {
        super(message);
    }

}
