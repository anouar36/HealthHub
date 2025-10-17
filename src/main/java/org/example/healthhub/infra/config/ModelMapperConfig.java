package org.example.healthhub.infra.config;

import  org.modelmapper.ModelMapper;
import  org.modelmapper.config.Configuration;

public class ModelMapperConfig{
    private final static ModelMapper modelMapper = new ModelMapper();

    static {

        modelMapper.getConfiguration()
                .setFieldMatchingEnabled(true)
                .setFieldAccessLevel(Configuration.AccessLevel.PRIVATE);

    }

    public static ModelMapper  getModelMapper(){
        return modelMapper;
    }

}