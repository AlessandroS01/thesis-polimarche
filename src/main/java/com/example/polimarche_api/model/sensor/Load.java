package com.example.polimarche_api.model.sensor;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "carico")
public class Load {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    @Column(name = "steer_torque")
    private Double steerTorque;
    @Column(name = "push_fr")
    private Double pushFR;
    @Column(name = "push_fl")
    private Double pushFL;
    @Column(name = "push_rr")
    private Double pushRR;
    @Column(name = "push_rl")
    private Double pushRL;

    public Load(Long id, Setup setup, PracticeSession sessione, Double steerTorque, Double pushFR, Double pushFL, Double pushRR, Double pushRL) {
        this.id = id;
        this.setup = setup;
        this.sessione = sessione;
        this.steerTorque = steerTorque;
        this.pushFR = pushFR;
        this.pushFL = pushFL;
        this.pushRR = pushRR;
        this.pushRL = pushRL;
    }

    public Load() {

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

    public Double getSteerTorque() {
        return steerTorque;
    }

    public void setSteerTorque(Double steerTorque) {
        this.steerTorque = steerTorque;
    }

    public Double getPushFR() {
        return pushFR;
    }

    public void setPushFR(Double pushFR) {
        this.pushFR = pushFR;
    }

    public Double getPushFL() {
        return pushFL;
    }

    public void setPushFL(Double pushFL) {
        this.pushFL = pushFL;
    }

    public Double getPushRR() {
        return pushRR;
    }

    public void setPushRR(Double pushRR) {
        this.pushRR = pushRR;
    }

    public Double getPushRL() {
        return pushRL;
    }

    public void setPushRL(Double pushRL) {
        this.pushRL = pushRL;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Load load = (Load) o;
        return Objects.equals(id, load.id) && Objects.equals(setup, load.setup) && Objects.equals(sessione, load.sessione) && Objects.equals(steerTorque, load.steerTorque) && Objects.equals(pushFR, load.pushFR) && Objects.equals(pushFL, load.pushFL) && Objects.equals(pushRR, load.pushRR) && Objects.equals(pushRL, load.pushRL);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, sessione, steerTorque, pushFR, pushFL, pushRR, pushRL);
    }

    @Override
    public String toString() {
        return "Load{" +
                "id=" + id +
                ", setup=" + setup +
                ", sessione=" + sessione +
                ", steerTorque=" + steerTorque +
                ", pushFR=" + pushFR +
                ", pushFL=" + pushFL +
                ", pushRR=" + pushRR +
                ", pushRL=" + pushRL +
                '}';
    }
}
