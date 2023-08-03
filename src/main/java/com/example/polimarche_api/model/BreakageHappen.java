package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name= "rottura_avvenuta")
public class BreakageHappen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;
    @ManyToOne
    @JoinColumn(name = "rottura")
    private Breakage rottura;
    private String descrizione;
    private Boolean pilota; // true if the breakage was driver fault

    public BreakageHappen() {
    }

    public BreakageHappen(Integer id, PracticeSession sessione, Breakage rottura, String descrizione, Boolean pilota) {
        this.id = id;
        this.sessione = sessione;
        this.rottura = rottura;
        this.descrizione = descrizione;
        this.pilota = pilota;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public PracticeSession getSessione() {
        return sessione;
    }

    public void setSessione(PracticeSession sessione) {
        this.sessione = sessione;
    }

    public Breakage getRottura() {
        return rottura;
    }

    public void setRottura(Breakage rottura) {
        this.rottura = rottura;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public Boolean getPilota() {
        return pilota;
    }

    public void setPilota(Boolean pilota) {
        this.pilota = pilota;
    }

    @Override
    public String toString() {
        return "HappenBreakage{" +
                "id=" + id +
                ", sessione=" + sessione +
                ", rottura=" + rottura +
                ", descrizione='" + descrizione + '\'' +
                ", colpa=" + pilota +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BreakageHappen that = (BreakageHappen) o;
        return Objects.equals(id, that.id) && Objects.equals(sessione, that.sessione) && Objects.equals(rottura, that.rottura) && Objects.equals(descrizione, that.descrizione) && Objects.equals(pilota, that.pilota);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, sessione, rottura, descrizione, pilota);
    }
}
