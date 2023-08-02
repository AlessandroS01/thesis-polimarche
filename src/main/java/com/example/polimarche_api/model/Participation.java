package com.example.polimarche_api.model;


import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "partecipazione")
public class Participation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "pilota")
    private Driver pilota;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;

    private Integer ordine;


    private String cambio_pilota;


    public Participation(Integer id, Driver pilota, PracticeSession sessione, Integer ordine, String cambio_pilota) {
        this.id = id;
        this.pilota = pilota;
        this.sessione = sessione;
        this.ordine = ordine;
        this.cambio_pilota = cambio_pilota;
    }
    public Participation() {

    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Driver getPilota() {
        return pilota;
    }

    public void setPilota(Driver pilota) {
        this.pilota = pilota;
    }

    public PracticeSession getSessione() {
        return sessione;
    }

    public void setSessione(PracticeSession sessione) {
        this.sessione = sessione;
    }

    public Integer getOrdine() {
        return ordine;
    }

    public void setOrdine(Integer ordine_pilota) {
        this.ordine = ordine_pilota;
    }

    public String getCambio_pilota() {
        return cambio_pilota;
    }

    public void setCambio_pilota(String cambio_pilota) {
        this.cambio_pilota = cambio_pilota;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Participation that = (Participation) o;
        return Objects.equals(id, that.id) && Objects.equals(pilota, that.pilota) && Objects.equals(sessione, that.sessione) && Objects.equals(ordine, that.ordine) && Objects.equals(cambio_pilota, that.cambio_pilota);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, pilota, sessione, ordine, cambio_pilota);
    }

    @Override
    public String toString() {
        return "DriverJoinSession{" +
                "id=" + id +
                ", pilota=" + pilota +
                ", sessione=" + sessione +
                ", ordine=" + ordine +
                ", cambio_pilota=" + cambio_pilota +
                '}';
    }
}
