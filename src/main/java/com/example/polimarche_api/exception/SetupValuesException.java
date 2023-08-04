package com.example.polimarche_api.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class SetupValuesException extends RuntimeException {

    public SetupValuesException(String message) {
        super(message);
    }

}
