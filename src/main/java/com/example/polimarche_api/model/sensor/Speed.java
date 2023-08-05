package com.example.polimarche_api.model.sensor;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "velocita")
public class Speed {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    @Column(name = "wheel_fr")
    private Double wheelFR;
    @Column(name = "wheel_fl")
    private Double wheelFL;

    public Speed(Long id, Setup setup, PracticeSession sessione, Double wheelFR, Double wheelFL) {
        this.id = id;
        this.setup = setup;
        this.sessione = sessione;
        this.wheelFR = wheelFR;
        this.wheelFL = wheelFL;
    }

    public Speed() {

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

    public Double getWheelFR() {
        return wheelFR;
    }

    public void setWheelFR(Double wheelFR) {
        this.wheelFR = wheelFR;
    }

    public Double getWheelFL() {
        return wheelFL;
    }

    public void setWheelFL(Double wheelFL) {
        this.wheelFL = wheelFL;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Speed speed = (Speed) o;
        return Objects.equals(id, speed.id) && Objects.equals(setup, speed.setup) && Objects.equals(sessione, speed.sessione) && Objects.equals(wheelFR, speed.wheelFR) && Objects.equals(wheelFL, speed.wheelFL);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, sessione, wheelFR, wheelFL);
    }

    @Override
    public String toString() {
        return "Speed{" +
                "id=" + id +
                ", setup=" + setup +
                ", sessione=" + sessione +
                ", wheelFR=" + wheelFR +
                ", wheelFL=" + wheelFL +
                '}';
    }
}
