package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "gomma")
public class Wheel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String codifica;
    private String posizione;
    @Column(name = "inclinazione_frontale")
    private String frontale;
    @Column(name = "inclinazione_superiore")
    private String superiore;
    private Double pressione;

    public Wheel(Integer id, String codifica, String posizione, String frontale, String superiore, Double pressione) {
        this.id = id;
        this.codifica = codifica;
        this.posizione = posizione;
        this.frontale = frontale;
        this.superiore = superiore;
        this.pressione = pressione;
    }

    public Wheel() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCodifica() {
        return codifica;
    }

    public void setCodifica(String codifica) {
        this.codifica = codifica;
    }

    public String getPosizione() {
        return posizione;
    }

    public void setPosizione(String posizione) {
        this.posizione = posizione;
    }

    public String getFrontale() {
        return frontale;
    }

    public void setFrontale(String frontale) {
        this.frontale = frontale;
    }

    public String getSuperiore() {
        return superiore;
    }

    public void setSuperiore(String superiore) {
        this.superiore = superiore;
    }

    public Double getPressione() {
        return pressione;
    }

    public void setPressione(Double pressione) {
        this.pressione = pressione;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Wheel wheel = (Wheel) o;
        return Objects.equals(id, wheel.id) && Objects.equals(codifica, wheel.codifica) && Objects.equals(posizione, wheel.posizione) && Objects.equals(frontale, wheel.frontale) && Objects.equals(superiore, wheel.superiore) && Objects.equals(pressione, wheel.pressione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, codifica, posizione, frontale, superiore, pressione);
    }

    @Override
    public String toString() {
        return "Wheel{" +
                "id=" + id +
                ", codifica='" + codifica + '\'' +
                ", posizione='" + posizione + '\'' +
                ", frontale='" + frontale + '\'' +
                ", superiore='" + superiore + '\'' +
                ", pressione=" + pressione +
                '}';
    }
}
