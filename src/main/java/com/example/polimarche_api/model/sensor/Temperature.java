package com.example.polimarche_api.model.sensor;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "temperatura")
public class Temperature {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    private Double igbt;
    @Column(name = "first_motor")
    private Double motorOne;
    @Column(name = "second_motor")
    private Double motorTwo;
    private Double inverter;
    private Double module;
    private Double pdm;
    @Column(name = "coolant_in")
    private Double coolantIn;
    @Column(name = "coolant_out")
    private Double coolantOut;
    private Double mcu;
    private Double vcu;
    private Double air;
    private Double humidity;
    @Column(name = "brake_fr")
    private Double brakeFR;
    @Column(name = "brake_fl")
    private Double brakeFL;
    @Column(name = "brake_rr")
    private Double brakeRR;
    @Column(name = "brake_rl")
    private Double brakeRL;
    @Column(name = "tyre_fr")
    private Double tyreFR;
    @Column(name = "tyre_fl")
    private Double tyreFL;
    @Column(name = "tyre_rr")
    private Double tyreRR;
    @Column(name = "tyre_rl")
    private Double tyreRL;

    public Temperature(Long id, Setup setup, PracticeSession sessione,
                       Double igbt, Double motorOne, Double motorTwo,
                       Double inverter, Double module, Double pdm,
                       Double coolantIn, Double coolantOut, Double mcu,
                       Double air, Double humidity, Double brakeFR,
                       Double brakeFL, Double brakeRR, Double brakeRL,
                       Double tyreFR, Double tyreFL, Double tyreRR,
                       Double tyreRL, Double vcu) {
        this.id = id;
        this.setup = setup;
        this.sessione = sessione;
        this.igbt = igbt;
        this.motorOne = motorOne;
        this.motorTwo = motorTwo;
        this.inverter = inverter;
        this.module = module;
        this.pdm = pdm;
        this.coolantIn = coolantIn;
        this.coolantOut = coolantOut;
        this.mcu = mcu;
        this.vcu = vcu;
        this.air = air;
        this.humidity = humidity;
        this.brakeFR = brakeFR;
        this.brakeFL = brakeFL;
        this.brakeRR = brakeRR;
        this.brakeRL = brakeRL;
        this.tyreFR = tyreFR;
        this.tyreFL = tyreFL;
        this.tyreRR = tyreRR;
        this.tyreRL = tyreRL;
    }

    public Temperature() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Setup getSetup() {
        return setup;
    }

    public void setSetup(Setup setup) {
        this.setup = setup;
    }

    public PracticeSession getSessione() {
        return sessione;
    }

    public void setSessione(PracticeSession sessione) {
        this.sessione = sessione;
    }

    public Double getIgbt() {
        return igbt;
    }

    public void setIgbt(Double igbt) {
        this.igbt = igbt;
    }

    public Double getMotorOne() {
        return motorOne;
    }

    public void setMotorOne(Double motorOne) {
        this.motorOne = motorOne;
    }

    public Double getMotorTwo() {
        return motorTwo;
    }

    public void setMotorTwo(Double motorTwo) {
        this.motorTwo = motorTwo;
    }

    public Double getInverter() {
        return inverter;
    }

    public void setInverter(Double inverter) {
        this.inverter = inverter;
    }

    public Double getModule() {
        return module;
    }

    public void setModule(Double module) {
        this.module = module;
    }

    public Double getPdm() {
        return pdm;
    }

    public void setPdm(Double pdm) {
        this.pdm = pdm;
    }

    public Double getCoolantIn() {
        return coolantIn;
    }

    public void setCoolantIn(Double coolantIn) {
        this.coolantIn = coolantIn;
    }

    public Double getCoolantOut() {
        return coolantOut;
    }

    public void setCoolantOut(Double coolantOut) {
        this.coolantOut = coolantOut;
    }

    public Double getMcu() {
        return mcu;
    }

    public void setMcu(Double mcu) {
        this.mcu = mcu;
    }

    public Double getAir() {
        return air;
    }

    public void setAir(Double air) {
        this.air = air;
    }

    public Double getHumidity() {
        return humidity;
    }

    public void setHumidity(Double humidity) {
        this.humidity = humidity;
    }

    public Double getBrakeFR() {
        return brakeFR;
    }

    public void setBrakeFR(Double brakeFR) {
        this.brakeFR = brakeFR;
    }

    public Double getBrakeFL() {
        return brakeFL;
    }

    public void setBrakeFL(Double brakeFL) {
        this.brakeFL = brakeFL;
    }

    public Double getBrakeRR() {
        return brakeRR;
    }

    public void setBrakeRR(Double brakeRR) {
        this.brakeRR = brakeRR;
    }

    public Double getBrakeRL() {
        return brakeRL;
    }

    public void setBrakeRL(Double brakeRL) {
        this.brakeRL = brakeRL;
    }

    public Double getTyreFR() {
        return tyreFR;
    }

    public void setTyreFR(Double tyreFR) {
        this.tyreFR = tyreFR;
    }

    public Double getTyreFL() {
        return tyreFL;
    }

    public void setTyreFL(Double tyreFL) {
        this.tyreFL = tyreFL;
    }

    public Double getTyreRR() {
        return tyreRR;
    }

    public void setTyreRR(Double tyreRR) {
        this.tyreRR = tyreRR;
    }

    public Double getTyreRL() {
        return tyreRL;
    }

    public void setTyreRL(Double tyreRL) {
        this.tyreRL = tyreRL;
    }

    public Double getVcu() {
        return vcu;
    }

    public void setVcu(Double vcu) {
        this.vcu = vcu;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Temperature that = (Temperature) o;
        return Objects.equals(id, that.id) && Objects.equals(setup, that.setup) && Objects.equals(sessione, that.sessione) && Objects.equals(igbt, that.igbt) && Objects.equals(motorOne, that.motorOne) && Objects.equals(motorTwo, that.motorTwo) && Objects.equals(inverter, that.inverter) && Objects.equals(module, that.module) && Objects.equals(pdm, that.pdm) && Objects.equals(coolantIn, that.coolantIn) && Objects.equals(coolantOut, that.coolantOut) && Objects.equals(mcu, that.mcu) && Objects.equals(vcu, that.vcu) && Objects.equals(air, that.air) && Objects.equals(humidity, that.humidity) && Objects.equals(brakeFR, that.brakeFR) && Objects.equals(brakeFL, that.brakeFL) && Objects.equals(brakeRR, that.brakeRR) && Objects.equals(brakeRL, that.brakeRL) && Objects.equals(tyreFR, that.tyreFR) && Objects.equals(tyreFL, that.tyreFL) && Objects.equals(tyreRR, that.tyreRR) && Objects.equals(tyreRL, that.tyreRL);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, sessione, igbt, motorOne, motorTwo, inverter, module, pdm, coolantIn, coolantOut, mcu, vcu, air, humidity, brakeFR, brakeFL, brakeRR, brakeRL, tyreFR, tyreFL, tyreRR, tyreRL);
    }

    @Override
    public String toString() {
        return "Temperature{" +
                "id=" + id +
                ", setup=" + setup +
                ", sessione=" + sessione +
                ", igbt=" + igbt +
                ", motorOne=" + motorOne +
                ", motorTwo=" + motorTwo +
                ", inverter=" + inverter +
                ", module=" + module +
                ", pdm=" + pdm +
                ", coolantIn=" + coolantIn +
                ", coolantOut=" + coolantOut +
                ", mcu=" + mcu +
                ", vcu=" + vcu +
                ", air=" + air +
                ", humidity=" + humidity +
                ", brakeFR=" + brakeFR +
                ", brakeFL=" + brakeFL +
                ", brakeRR=" + brakeRR +
                ", brakeRL=" + brakeRL +
                ", tyreFR=" + tyreFR +
                ", tyreFL=" + tyreFL +
                ", tyreRR=" + tyreRR +
                ", tyreRL=" + tyreRL +
                '}';
    }
}
