package com.example.polimarche_api.model.sensor;

import com.example.polimarche_api.model.PracticeSession;
import com.example.polimarche_api.model.Setup;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "corrente")
public class Current {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    @Column(name = "bp_current")
    private Double bpCurrent;
    @Column(name = "lv_battery")
    private Double lvBattery;
    @Column(name = "water_pump")
    private Double waterPump;
    @Column(name = "cooling_fan_sys")
    private Double coolingFanSys;

    public Current(Long id, Setup setup, PracticeSession sessione, Double bpCurrent, Double lvBattery, Double waterPump, Double coolingFanSys) {
        this.id = id;
        this.setup = setup;
        this.sessione = sessione;
        this.bpCurrent = bpCurrent;
        this.lvBattery = lvBattery;
        this.waterPump = waterPump;
        this.coolingFanSys = coolingFanSys;
    }

    public Current() {

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

    public Double getBpCurrent() {
        return bpCurrent;
    }

    public void setBpCurrent(Double bpCurrent) {
        this.bpCurrent = bpCurrent;
    }

    public Double getLvBattery() {
        return lvBattery;
    }

    public void setLvBattery(Double lvBattery) {
        this.lvBattery = lvBattery;
    }

    public Double getWaterPump() {
        return waterPump;
    }

    public void setWaterPump(Double waterPump) {
        this.waterPump = waterPump;
    }

    public Double getCoolingFanSys() {
        return coolingFanSys;
    }

    public void setCoolingFanSys(Double coolingFanSys) {
        this.coolingFanSys = coolingFanSys;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Current current = (Current) o;
        return Objects.equals(id, current.id) && Objects.equals(setup, current.setup) && Objects.equals(sessione, current.sessione) && Objects.equals(bpCurrent, current.bpCurrent) && Objects.equals(lvBattery, current.lvBattery) && Objects.equals(waterPump, current.waterPump) && Objects.equals(coolingFanSys, current.coolingFanSys);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, sessione, bpCurrent, lvBattery, waterPump, coolingFanSys);
    }

    @Override
    public String toString() {
        return "Current{" +
                "id=" + id +
                ", setup=" + setup +
                ", sessione=" + sessione +
                ", bpCurrent=" + bpCurrent +
                ", lvBattery=" + lvBattery +
                ", waterPump=" + waterPump +
                ", coolingFanSys=" + coolingFanSys +
                '}';
    }
}
