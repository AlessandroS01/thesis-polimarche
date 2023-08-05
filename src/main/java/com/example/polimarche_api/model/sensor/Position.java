package com.example.polimarche_api.model.sensor;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "posizione")
public class Position {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    private Double throttle;
    @Column(name = "steering_angle")
    private Double steeringAngle;
    @Column(name = "suspension_fr")
    private Double suspensionFR;
    @Column(name = "suspension_fl")
    private Double suspensionFL;
    @Column(name = "suspension_rr")
    private Double suspensionRR;
    @Column(name = "suspension_rl")
    private Double suspensionRL;

    public Position(Long id, Setup setup, PracticeSession sessione, Double throttle, Double steeringAngle, Double suspensionFR, Double suspensionFL, Double suspensionRR, Double suspensionRL) {
        this.id = id;
        this.setup = setup;
        this.sessione = sessione;
        this.throttle = throttle;
        this.steeringAngle = steeringAngle;
        this.suspensionFR = suspensionFR;
        this.suspensionFL = suspensionFL;
        this.suspensionRR = suspensionRR;
        this.suspensionRL = suspensionRL;
    }

    public Position() {

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

    public Double getThrottle() {
        return throttle;
    }

    public void setThrottle(Double throttle) {
        this.throttle = throttle;
    }

    public Double getSteeringAngle() {
        return steeringAngle;
    }

    public void setSteeringAngle(Double steeringAngle) {
        this.steeringAngle = steeringAngle;
    }

    public Double getSuspensionFR() {
        return suspensionFR;
    }

    public void setSuspensionFR(Double suspensionFR) {
        this.suspensionFR = suspensionFR;
    }

    public Double getSuspensionFL() {
        return suspensionFL;
    }

    public void setSuspensionFL(Double suspensionFL) {
        this.suspensionFL = suspensionFL;
    }

    public Double getSuspensionRR() {
        return suspensionRR;
    }

    public void setSuspensionRR(Double suspensionRR) {
        this.suspensionRR = suspensionRR;
    }

    public Double getSuspensionRL() {
        return suspensionRL;
    }

    public void setSuspensionRL(Double suspensionRL) {
        this.suspensionRL = suspensionRL;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Position position = (Position) o;
        return Objects.equals(id, position.id) && Objects.equals(setup, position.setup) && Objects.equals(sessione, position.sessione) && Objects.equals(throttle, position.throttle) && Objects.equals(steeringAngle, position.steeringAngle) && Objects.equals(suspensionFR, position.suspensionFR) && Objects.equals(suspensionFL, position.suspensionFL) && Objects.equals(suspensionRR, position.suspensionRR) && Objects.equals(suspensionRL, position.suspensionRL);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, sessione, throttle, steeringAngle, suspensionFR, suspensionFL, suspensionRR, suspensionRL);
    }

    @Override
    public String toString() {
        return "Position{" +
                "id=" + id +
                ", setup=" + setup +
                ", sessione=" + sessione +
                ", throttle=" + throttle +
                ", steeringAngle=" + steeringAngle +
                ", suspensionFR=" + suspensionFR +
                ", suspensionFL=" + suspensionFL +
                ", suspensionRR=" + suspensionRR +
                ", suspensionRL=" + suspensionRL +
                '}';
    }
}
