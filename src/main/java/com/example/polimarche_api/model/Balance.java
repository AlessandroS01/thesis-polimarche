package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "bilanciamento")
public class Balance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String posizione;
    private Double frenata;
    private Double peso;

    public Balance(Integer id, String posizione, Double frenata, Double peso) {
        this.id = id;
        this.posizione = posizione;
        this.frenata = frenata;
        this.peso = peso;
    }

    public Balance() {

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

    public Double getFrenata() {
        return frenata;
    }

    public void setFrenata(Double frenata) {
        this.frenata = frenata;
    }

    public Double getPeso() {
        return peso;
    }

    public void setPeso(Double peso) {
        this.peso = peso;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Balance balance = (Balance) o;
        return Objects.equals(id, balance.id) && Objects.equals(posizione, balance.posizione) && Objects.equals(frenata, balance.frenata) && Objects.equals(peso, balance.peso);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, posizione, frenata, peso);
    }

    @Override
    public String toString() {
        return "Balance{" +
                "id=" + id +
                ", posizione='" + posizione + '\'' +
                ", frenata=" + frenata +
                ", peso=" + peso +
                '}';
    }
}
