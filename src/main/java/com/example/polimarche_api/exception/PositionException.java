package com.example.polimarche_api.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class PositionException extends RuntimeException {

    public PositionException(String message) {
        super(message);
    }

}
