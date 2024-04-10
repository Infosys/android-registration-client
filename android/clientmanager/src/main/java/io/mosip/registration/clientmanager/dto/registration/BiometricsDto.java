package io.mosip.registration.clientmanager.dto.registration;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class BiometricsDto {

    private String modality;
    private String bioSubType;
    private String bioValue;
    private String specVersion;
    private boolean isException;
    private String decodedBioResponse;
    private String signature;
    private boolean isForceCaptured;
    private int numOfRetries;
    private double sdkScore;
    private float qualityScore;

    private String comment="";

    public BiometricsDto(String modality,String bioSubType,String bioValue,String specVersion,boolean isException,String decodedBioResponse,String signature,boolean isForceCaptured,int numOfRetries,double sdkScore,float qualityScore){
        this.modality=modality;
        this.bioSubType=bioSubType;
        this.bioValue=bioValue;
        this.specVersion=specVersion;
        this.isException=isException;
        this.decodedBioResponse=decodedBioResponse;
        this.signature=signature;
        this.isForceCaptured=isForceCaptured;
        this.numOfRetries=numOfRetries;
        this.sdkScore=sdkScore;
        this.qualityScore=qualityScore;
    }




    public void setComment(String comment){
        this.comment=comment;
    }

    public String getComment(){
        return comment;
    }

    public void setIsException(boolean exception) {
        isException = exception;
    }

    public void setIsForceCaptured(boolean forceCaptured) {
        isForceCaptured = forceCaptured;
    }


    public String getBioSubType() {
        return  bioSubType;
    }
    public String getBioValue(){
        return bioValue;
    }

    public String getModality(){return  modality;}
}
