package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "ammortizzatore")
public class Damper {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String posizione;
    private Double lsr;
    private Double hsr;
    private Double lsc;
    private Double hsc;

    public Damper(Integer id, String posizione, Double lsr, Double hsr, Double lsc, Double hsc) {
        this.id = id;
        this.posizione = posizione;
        this.lsr = lsr;
        this.hsr = hsr;
        this.lsc = lsc;
        this.hsc = hsc;
    }

    public Damper() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPosizione() {
        return posizione;
    }

    public void setPosizione(String posizione) {
        this.posizione = posizione;
    }

    public Double getLsr() {
        return lsr;
    }

    public void setLsr(Double lsr) {
        this.lsr = lsr;
    }

    public Double getHsr() {
        return hsr;
    }

    public void setHsr(Double hsr) {
        this.hsr = hsr;
    }

    public Double getLsc() {
        return lsc;
    }

    public void setLsc(Double lsc) {
        this.lsc = lsc;
    }

    public Double getHsc() {
        return hsc;
    }

    public void setHsc(Double hsc) {
        this.hsc = hsc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Damper damper = (Damper) o;
        return Objects.equals(id, damper.id) && Objects.equals(posizione, damper.posizione) && Objects.equals(lsr, damper.lsr) && Objects.equals(hsr, damper.hsr) && Objects.equals(lsc, damper.lsc) && Objects.equals(hsc, damper.hsc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, posizione, lsr, hsr, lsc, hsc);
    }

    @Override
    public String toString() {
        return "Damper{" +
                "id=" + id +
                ", posizione='" + posizione + '\'' +
                ", lsr=" + lsr +
                ", hsr=" + hsr +
                ", lsc=" + lsc +
                ", hsc=" + hsc +
                '}';
    }
}
