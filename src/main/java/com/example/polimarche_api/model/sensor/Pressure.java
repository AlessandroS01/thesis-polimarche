package com.example.polimarche_api.model.sensor;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "pressione")
public class Pressure {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    @Column(name = "brake_f")
    private Double brakeF;
    @Column(name = "brake_r")
    private Double brakeR;
    private Double coolant;

    public Pressure(Long id, Setup setup, PracticeSession sessione, Double brakeF, Double brakeR, Double coolant) {
        this.id = id;
        this.setup = setup;
        this.sessione = sessione;
        this.brakeF = brakeF;
        this.brakeR = brakeR;
        this.coolant = coolant;
    }

    public Pressure() {

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

    public Double getBrakeF() {
        return brakeF;
    }

    public void setBrakeF(Double brakeF) {
        this.brakeF = brakeF;
    }

    public Double getBrakeR() {
        return brakeR;
    }

    public void setBrakeR(Double brakeR) {
        this.brakeR = brakeR;
    }

    public Double getCoolant() {
        return coolant;
    }

    public void setCoolant(Double coolant) {
        this.coolant = coolant;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pressure pressure = (Pressure) o;
        return Objects.equals(id, pressure.id) && Objects.equals(setup, pressure.setup) && Objects.equals(sessione, pressure.sessione) && Objects.equals(brakeF, pressure.brakeF) && Objects.equals(brakeR, pressure.brakeR) && Objects.equals(coolant, pressure.coolant);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, sessione, brakeF, brakeR, coolant);
    }

    @Override
    public String toString() {
        return "Pressure{" +
                "id=" + id +
                ", setup=" + setup +
                ", sessione=" + sessione +
                ", brakeF=" + brakeF +
                ", brakeR=" + brakeR +
                ", coolant=" + coolant +
                '}';
    }
}
