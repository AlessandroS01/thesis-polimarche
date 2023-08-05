package com.example.polimarche_api.model.sensor;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "voltaggio")
public class Voltage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    @Column(name = "lv_battery")
    private Double lvBattery;
    @Column(name = "source_24v")
    private Double source24V;
    @Column(name = "source_5v")
    private Double source5V;

    public Voltage(Long id, Setup setup, PracticeSession sessione, Double lvBattery, Double source24V, Double source5V) {
        this.id = id;
        this.setup = setup;
        this.sessione = sessione;
        this.lvBattery = lvBattery;
        this.source24V = source24V;
        this.source5V = source5V;
    }

    public Voltage() {

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

    public Double getLvBattery() {
        return lvBattery;
    }

    public void setLvBattery(Double lvBattery) {
        this.lvBattery = lvBattery;
    }

    public Double getSource24V() {
        return source24V;
    }

    public void setSource24V(Double source24V) {
        this.source24V = source24V;
    }

    public Double getSource5V() {
        return source5V;
    }

    public void setSource5V(Double source5V) {
        this.source5V = source5V;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Voltage voltage = (Voltage) o;
        return Objects.equals(id, voltage.id) && Objects.equals(setup, voltage.setup) && Objects.equals(sessione, voltage.sessione) && Objects.equals(lvBattery, voltage.lvBattery) && Objects.equals(source24V, voltage.source24V) && Objects.equals(source5V, voltage.source5V);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, sessione, lvBattery, source24V, source5V);
    }

    @Override
    public String toString() {
        return "Voltage{" +
                "id=" + id +
                ", setup=" + setup +
                ", sessione=" + sessione +
                ", lvBattery=" + lvBattery +
                ", source24V=" + source24V +
                ", source5V=" + source5V +
                '}';
    }
}
